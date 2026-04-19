"""
학습 파일을 스캔하여 manifest.json 생성 + ipynb → HTML 변환
"""
import json
import os
import re
import shutil
import subprocess
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent.parent
WEBSITE_ROOT = Path(__file__).parent.parent
OUTPUT_DIR = WEBSITE_ROOT / "public" / "content"
NOTEBOOKS_DIR = OUTPUT_DIR / "notebooks"

EXCLUDE_DIRS = {".venv", ".git", "website", "__pycache__", ".ipynb_checkpoints", "node_modules"}
SUPPORTED_EXTENSIONS = {".ipynb", ".pdf", ".py", ".sql", ".md", ".txt", ".csv"}


def get_tags(file_path: Path, rel_path: Path) -> list[str]:
    """파일 경로/이름 규칙으로 태그 자동 부여"""
    tags = []
    parts = rel_path.parts
    name = file_path.stem
    top_folder = parts[0] if parts else ""

    # 최상위 폴더 기반 카테고리
    top_num = re.match(r"^(\d+)", top_folder)
    if top_folder == "98.코딩테스트":
        tags.append("코딩테스트")
    elif top_folder == "99.참고자료":
        tags.append("참고자료")
    elif top_num and int(top_num.group(1)) >= 70:
        tags.append("프로젝트")

    # 경로 내 폴더명 기반 태그
    path_str = str(rel_path)
    if any(p in path_str for p in ["96_강의코드", "96.강의코드"]):
        tags.append("강의코드")
    if any(p in path_str for p in ["95_강의자료", "95.강의자료"]):
        tags.append("강의자료")
    if any(p in path_str for p in ["97_실습자료", "97.실습자료"]):
        tags.append("실습")
    if any(p in path_str for p in ["98_실습답안", "98.실습답안"]):
        tags.append("답안")

    # 파일명 기반 태그
    if name.startswith("실습") and "_답안" in name:
        if "답안" not in tags:
            tags.append("답안")
    elif name.startswith("실습"):
        if "실습" not in tags:
            tags.append("실습")

    if not tags:
        # 기본적으로 번호 폴더 안 ipynb는 강의코드로 간주
        if file_path.suffix == ".ipynb" and re.match(r"^\d+_", name):
            tags.append("강의코드")

    return tags


def safe_filename(rel_path: Path) -> str:
    """경로를 파일명으로 변환 (폴더 구분자 → __)"""
    return str(rel_path).replace("/", "__").replace("\\", "__")


def is_up_to_date(src: Path, dest: Path) -> bool:
    """dest가 존재하고 src보다 최신이면 True"""
    return dest.exists() and dest.stat().st_mtime >= src.stat().st_mtime


def convert_notebook(ipynb_path: Path, output_html: Path) -> bool:
    """nbconvert로 ipynb → HTML 변환 (이미 최신이면 건너뜀)"""
    if is_up_to_date(ipynb_path, output_html):
        return True  # 스킵
    try:
        output_html.parent.mkdir(parents=True, exist_ok=True)
        result = subprocess.run(
            [
                "jupyter", "nbconvert", "--to", "html",
                "--output", str(output_html.name),
                "--output-dir", str(output_html.parent),
                str(ipynb_path),
            ],
            capture_output=True, text=True, timeout=60
        )
        return result.returncode == 0
    except Exception as e:
        print(f"  변환 실패: {ipynb_path.name} — {e}")
        return False


def find_pairs(siblings: list[dict]) -> dict[str, str]:
    """
    같은 폴더 내 파일 pair 매핑 반환
    실습03_xxx ↔ 03_xxx, 실습03_xxx_답안 ↔ 실습03_xxx
    """
    pairs: dict[str, str] = {}
    names = {f["name"]: f for f in siblings if f["type"] != "folder"}

    for file in siblings:
        if file["type"] == "folder":
            continue
        name = file["name"]
        stem = Path(name).stem
        ext = Path(name).suffix

        # 실습 파일이면 → 매칭되는 강의 파일 찾기
        if stem.startswith("실습"):
            # 실습03_리스트_답안 → 03_리스트 or 실습03_리스트
            no_prefix = stem[2:]  # 실습 제거
            if "_답안" in no_prefix:
                base = no_prefix.replace("_답안", "")
                practice = f"실습{base}{ext}"
                if practice in names:
                    pairs[name] = practice
            else:
                # 실습03_리스트 → 03_리스트
                candidate = f"{no_prefix}{ext}"
                if candidate in names:
                    pairs[name] = candidate

        # 강의 파일이면 → 매칭되는 실습 파일 찾기
        elif re.match(r"^\d+_", stem):
            practice = f"실습{stem}{ext}"
            if practice in names:
                pairs[name] = practice

    return pairs


def scan_directory(dir_path: Path, rel_base: Path) -> list[dict]:
    """디렉토리 재귀 스캔 → 노드 리스트 반환"""
    nodes = []

    try:
        entries = sorted(dir_path.iterdir(), key=lambda p: (p.is_file(), p.name))
    except PermissionError:
        return nodes

    files_in_dir = []

    for entry in entries:
        if entry.name in EXCLUDE_DIRS or entry.name.startswith("."):
            continue

        rel_path = rel_base / entry.name

        if entry.is_dir():
            children = scan_directory(entry, rel_path)
            if children:  # 빈 폴더 제외
                nodes.append({
                    "name": entry.name,
                    "type": "folder",
                    "path": str(rel_path),
                    "children": children,
                })

        elif entry.is_file() and entry.suffix.lower() in SUPPORTED_EXTENSIONS:
            tags = get_tags(entry, rel_path)
            node: dict = {
                "name": entry.name,
                "type": "file",
                "path": str(rel_path),
                "ext": entry.suffix.lower(),
                "tags": tags,
            }

            if entry.suffix.lower() == ".ipynb":
                node["type"] = "notebook"
                html_name = safe_filename(rel_path.with_suffix(".html"))
                html_output = NOTEBOOKS_DIR / html_name
                node["convertedPath"] = f"content/notebooks/{html_name}"

                if not is_up_to_date(entry, html_output):
                    print(f"  변환 중: {rel_path}")
                success = convert_notebook(entry, html_output)
                if not success:
                    node["convertedPath"] = None

            elif entry.suffix.lower() == ".pdf":
                pdf_dir = OUTPUT_DIR / "pdfs"
                pdf_dir.mkdir(parents=True, exist_ok=True)
                pdf_dest_name = safe_filename(rel_path)
                pdf_dest = pdf_dir / pdf_dest_name
                if not is_up_to_date(entry, pdf_dest):
                    shutil.copy2(entry, pdf_dest)
                node["type"] = "pdf"
                node["pdfPath"] = f"content/pdfs/{pdf_dest_name}"

            elif entry.suffix.lower() in {".py", ".sql", ".md", ".txt"}:
                # 텍스트 파일은 내용 직접 읽기
                try:
                    node["content"] = entry.read_text(encoding="utf-8", errors="replace")
                except Exception:
                    node["content"] = ""

            files_in_dir.append(node)

    # pair 연결
    pairs = find_pairs(files_in_dir)
    for node in files_in_dir:
        if node["name"] in pairs:
            node["pair"] = pairs[node["name"]]

    nodes.extend(files_in_dir)
    return nodes


def main():
    print("=== sk_network 학습 파일 빌드 시작 ===\n")

    NOTEBOOKS_DIR.mkdir(parents=True, exist_ok=True)
    (OUTPUT_DIR / "pdfs").mkdir(parents=True, exist_ok=True)

    print("파일 스캔 및 변환 중...\n")
    tree = scan_directory(REPO_ROOT, Path(""))

    # 사용된 출력 파일 목록 수집 (고아 파일 정리용)
    def collect_outputs(nodes: list) -> tuple[set, set]:
        htmls: set = set()
        pdfs: set = set()
        for n in nodes:
            if n.get("convertedPath"):
                htmls.add(Path(n["convertedPath"]).name)
            if n.get("pdfPath"):
                pdfs.add(Path(n["pdfPath"]).name)
            if n.get("children"):
                h, p = collect_outputs(n["children"])
                htmls |= h
                pdfs |= p
        return htmls, pdfs

    used_htmls, used_pdfs = collect_outputs(tree)

    # 더 이상 쓰이지 않는 파일 삭제
    for f in NOTEBOOKS_DIR.glob("*.html"):
        if f.name not in used_htmls:
            f.unlink()
    for f in (OUTPUT_DIR / "pdfs").glob("*.pdf"):
        if f.name not in used_pdfs:
            f.unlink()

    manifest = {"tree": tree}
    manifest_path = OUTPUT_DIR / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")

    # 통계
    def count_files(nodes: list) -> dict:
        counts: dict = {"notebook": 0, "pdf": 0, "file": 0, "folder": 0}
        for n in nodes:
            counts[n["type"]] = counts.get(n["type"], 0) + 1
            if n["type"] == "folder":
                sub = count_files(n.get("children", []))
                for k, v in sub.items():
                    counts[k] = counts.get(k, 0) + v
        return counts

    stats = count_files(tree)
    print(f"\n=== 빌드 완료 ===")
    print(f"  노트북: {stats.get('notebook', 0)}개")
    print(f"  PDF: {stats.get('pdf', 0)}개")
    print(f"  코드/텍스트: {stats.get('file', 0)}개")
    print(f"  manifest.json → {manifest_path}")


def watch():
    """파일 변경 감지 시 자동으로 main() 재실행"""
    from watchdog.observers import Observer
    from watchdog.events import FileSystemEventHandler
    import threading
    import time

    WATCH_EXTENSIONS = {".ipynb", ".pdf", ".py", ".sql", ".md"}
    _timer: list = [None]
    _lock = threading.Lock()

    class Handler(FileSystemEventHandler):
        def on_any_event(self, event):
            if event.is_directory:
                return
            path = Path(event.src_path)
            # website/, .git/, .venv/ 변경은 무시
            if any(p in str(path) for p in ["website", ".git", ".venv", "__pycache__"]):
                return
            if path.suffix.lower() not in WATCH_EXTENSIONS:
                return

            # 연속 변경 디바운스 (1초)
            with _lock:
                if _timer[0]:
                    _timer[0].cancel()
                t = threading.Timer(1.0, _rebuild, args=[path])
                _timer[0] = t
                t.start()

    def _rebuild(changed: Path):
        print(f"\n[변경 감지] {changed.name} → 재빌드 중...")
        try:
            main()
        except Exception as e:
            print(f"[오류] {e}")

    observer = Observer()
    observer.schedule(Handler(), str(REPO_ROOT), recursive=True)
    observer.start()
    print(f"=== Watch 모드 시작 ===")
    print(f"  감시 중: {REPO_ROOT}")
    print(f"  .ipynb/.pdf/.py/.sql 변경 시 자동 재빌드")
    print(f"  종료: Ctrl+C\n")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()


if __name__ == "__main__":
    import sys
    if "--watch" in sys.argv:
        main()   # 초기 빌드
        watch()
    else:
        main()
