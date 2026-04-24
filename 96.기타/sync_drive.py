#!/usr/bin/env python3
"""Fast read-only Google Drive downloader for this lecture workspace."""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
import tempfile
import time
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path


REMOTE = "play_data:"
ROOT_FOLDER_ID = "1lpBA7hXCIQhNgYkrF_qxieyqcCkjKMj4"
STATE_FILE = Path(".drive_state.json")

RCLONE_FAST_FLAGS = [
    "--drive-root-folder-id",
    ROOT_FOLDER_ID,
    "--fast-list",
    "--transfers",
    "4",
    "--checkers",
    "8",
    "--drive-pacer-min-sleep",
    "100ms",
    "--drive-pacer-burst",
    "20",
    "--no-update-modtime",
]

CODE_DIR_ALIASES = {
    "01_강의 자료": "자료",
    "02_강의 코드": "강의코드",
    "03_실습 코드": "실습코드",
}

REFRESH_EXTENSIONS = {".md"}


@dataclass(frozen=True)
class DriveFile:
    path: str
    mod_time: str
    size: int | None


@dataclass(frozen=True)
class CopyItem:
    source_root: str
    dest_root: Path
    rel_path: str
    overwrite: bool


def run(cmd: list[str], *, capture: bool = False) -> subprocess.CompletedProcess[str]:
    kwargs = {
        "text": True,
        "check": True,
    }
    if capture:
        kwargs["stdout"] = subprocess.PIPE
    return subprocess.run(cmd, **kwargs)


def has_custom_drive_client() -> bool:
    result = run(["rclone", "config", "show", "play_data"], capture=True)
    return "client_id =" in result.stdout


def rclone_path(path: str = "") -> str:
    return f"{REMOTE}{path}" if path else REMOTE


def list_drive_files(folders: list[str]) -> list[DriveFile]:
    files: dict[str, DriveFile] = {}
    targets = folders or [""]

    for folder in targets:
        cmd = [
            "rclone",
            "lsjson",
            "--recursive",
            "--files-only",
            rclone_path(folder),
            "--drive-root-folder-id",
            ROOT_FOLDER_ID,
        ]
        result = run(cmd, capture=True)
        for item in json.loads(result.stdout):
            rel_path = item.get("Path")
            if not rel_path:
                continue
            path = f"{folder.rstrip('/')}/{rel_path}" if folder else rel_path
            files[path] = DriveFile(
                path=path,
                mod_time=item.get("ModTime", ""),
                size=item.get("Size"),
            )

    return [files[path] for path in sorted(files)]


def load_state() -> dict[str, dict[str, object]]:
    if not STATE_FILE.exists():
        return {}

    raw_state = json.loads(STATE_FILE.read_text(encoding="utf-8"))
    if isinstance(raw_state, list):
        return {path: {"mod_time": "", "size": None} for path in raw_state}
    if isinstance(raw_state, dict):
        return raw_state
    raise ValueError(f"Unsupported state format in {STATE_FILE}")


def save_state(
    previous: dict[str, dict[str, object]],
    drive_files: list[DriveFile],
    folders: list[str],
) -> None:
    # rclone/Drive can occasionally omit Colab notebooks from a listing. The
    # workflow tracks additions only, so never remove paths just because a list
    # call did not return them this time.
    next_state = dict(previous)
    for drive_file in drive_files:
        next_state[drive_file.path] = {
            "mod_time": drive_file.mod_time,
            "size": drive_file.size,
        }

    STATE_FILE.write_text(
        json.dumps(next_state, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )


def source_and_dest(path: str) -> tuple[str, Path, str]:
    parts = path.split("/")
    top = parts[0]

    if len(parts) == 1:
        return top, Path(top) / "자료", parts[0]

    first = parts[1]
    if first in CODE_DIR_ALIASES:
        source_root = f"{top}/{first}"
        dest_root = Path(top) / CODE_DIR_ALIASES[first]
        if len(parts) == 2:
            return top, dest_root, first
        rel_path = "/".join(parts[2:])
        return source_root, dest_root, rel_path

    if first in {"강의코드", "실습코드", "자료"}:
        source_root = f"{top}/{first}"
        dest_root = Path(top) / first
        if len(parts) == 2:
            return top, dest_root, first
        rel_path = "/".join(parts[2:])
        return source_root, dest_root, rel_path

    if len(parts) == 2:
        return top, Path(top) / "자료", first

    source_root = f"{top}/{first}"
    dest_root = Path(top) / first
    rel_path = "/".join(parts[2:])
    return source_root, dest_root, rel_path


def make_copy_items(
    drive_files: list[DriveFile],
    previous: dict[str, dict[str, object]],
    *,
    refresh_tutors: bool,
) -> list[CopyItem]:
    items: list[CopyItem] = []
    for drive_file in drive_files:
        path = drive_file.path
        tutor = "튜터용" in path
        refresh_extension = Path(path).suffix.lower() in REFRESH_EXTENSIONS
        refreshable = (refresh_tutors and tutor) or refresh_extension
        previous_file = previous.get(path)
        changed = (
            previous_file is None
            or previous_file.get("mod_time") != drive_file.mod_time
            or previous_file.get("size") != drive_file.size
        )
        if not changed:
            continue
        overwrite = previous_file is not None and refreshable
        if previous_file is not None and not refreshable:
            continue

        source_root, dest_root, rel_path = source_and_dest(path)
        if not rel_path:
            continue
        items.append(CopyItem(source_root, dest_root, rel_path, overwrite))

    return items


def copy_grouped(items: list[CopyItem], *, dry_run: bool) -> tuple[int, int]:
    groups: dict[tuple[str, Path, bool], list[str]] = defaultdict(list)
    for item in items:
        groups[(item.source_root, item.dest_root, item.overwrite)].append(item.rel_path)

    copied_groups = 0
    for (source_root, dest_root, overwrite), rel_paths in sorted(groups.items()):
        dest_root.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile("w", encoding="utf-8", delete=False) as handle:
            list_path = Path(handle.name)
            handle.write("\n".join(sorted(set(rel_paths))) + "\n")

        cmd = [
            "rclone",
            "copy",
            rclone_path(source_root),
            str(dest_root),
            "--files-from",
            str(list_path),
            *RCLONE_FAST_FLAGS,
        ]
        if not overwrite:
            cmd.append("--ignore-existing")
        if dry_run:
            cmd.append("--dry-run")

        print(
            f"{'DRY ' if dry_run else ''}COPY {source_root} -> {dest_root} "
            f"({len(set(rel_paths))} files, {'overwrite refresh files' if overwrite else 'new only'})",
            flush=True,
        )
        try:
            run(cmd)
        finally:
            list_path.unlink(missing_ok=True)
        copied_groups += 1

    return copied_groups, sum(len(set(paths)) for paths in groups.values())


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Download new Google Drive lecture files quickly without writing to Drive."
    )
    parser.add_argument(
        "folders",
        nargs="*",
        help="Optional top-level folders to refresh, e.g. 08_머신러닝",
    )
    parser.add_argument(
        "--no-refresh-tutors",
        action="store_true",
        help="Do not overwrite existing '(튜터용)' files with the Drive copy.",
    )
    parser.add_argument("--dry-run", action="store_true", help="Show rclone work without copying.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    folders = [folder.rstrip("/") for folder in args.folders]
    started = time.monotonic()

    if not has_custom_drive_client():
        print(
            "Note: play_data uses rclone's built-in Google OAuth client. "
            "A custom client_id/client_secret is the next speed and quota upgrade.",
            flush=True,
        )

    previous = load_state()
    drive_files = list_drive_files(folders)
    items = make_copy_items(
        drive_files,
        previous,
        refresh_tutors=not args.no_refresh_tutors,
    )

    new_count = sum(1 for drive_file in drive_files if drive_file.path not in previous)
    changed_count = sum(
        1
        for drive_file in drive_files
        if drive_file.path in previous
        and (
            previous[drive_file.path].get("mod_time") != drive_file.mod_time
            or previous[drive_file.path].get("size") != drive_file.size
        )
    )
    overwrite_count = sum(1 for item in items if item.overwrite)

    print(f"Drive files scanned: {len(drive_files)}", flush=True)
    print(f"New paths: {new_count}", flush=True)
    print(f"Changed paths: {changed_count}", flush=True)
    print(
        f"Copy candidates: {len(items)} ({overwrite_count} overwrite refresh candidates)",
        flush=True,
    )

    groups, files = copy_grouped(items, dry_run=args.dry_run) if items else (0, 0)
    if not args.dry_run:
        save_state(previous, drive_files, folders)

    elapsed = time.monotonic() - started
    print(f"Done: {files} files across {groups} rclone copy groups in {elapsed:.1f}s", flush=True)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        print(f"Command failed: {' '.join(exc.cmd)}", file=sys.stderr)
        raise SystemExit(exc.returncode)
