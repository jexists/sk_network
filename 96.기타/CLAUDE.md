# CLAUDE.md

## 강의 Google Drive 최신화 규칙

이 폴더는 Google Drive `Family_AI_camp_30기` 내용을 로컬로 받아 쓰는 작업 공간이다.

> Google Drive는 읽기 전용으로 취급한다. Drive에 파일을 추가, 수정, 삭제하지 않는다.

## 기본 실행

드라이브 최신화 요청을 받으면 파일별 `rclone copyto`를 반복하지 말고 전용 스크립트를 사용한다.

```bash
python3 sync_drive.py
```

특정 폴더만 요청받으면 해당 폴더명을 인자로 넘긴다.

```bash
python3 sync_drive.py 08_머신러닝
```

실행 계획만 확인해야 하면:

```bash
python3 sync_drive.py --dry-run
```

## 동기화 방식

- `sync_drive.py`가 Drive listing을 조회하고 `.drive_state.json`과 비교한다.
- 신규 파일은 목적지별로 묶어서 `rclone copy --files-from`으로 배치 복사한다.
- 일반 파일은 `--ignore-existing`으로 기존 로컬 파일을 덮어쓰지 않는다.
- `(튜터용)` 파일과 `.md` 파일은 Drive 수정 시각/크기가 바뀐 경우 최신본으로 덮어쓴다.
- `.drive_state.json`은 Drive 파일별 경로, 수정 시각, 크기를 누적한다. Drive listing 누락 가능성 때문에 기존 항목을 제거하지 않는다.

## 속도 관련

- `play_data` remote는 전용 Google OAuth client를 사용하도록 설정되어 있다.
- 기본 rclone 옵션은 `--fast-list --transfers 4 --checkers 8`이다.
- API rate limit이 다시 발생하면 `sync_drive.py`의 `RCLONE_FAST_FLAGS`에서 `transfers`, `checkers`, `drive-pacer-burst`를 낮춘다.
- 다운로드가 느리다고 해서 `gdrive` 같은 별도 CLI로 갈아타지 않는다. 현재 병목은 CLI 종류보다 Drive API listing/쿼터에 가깝다.

## 경로 매핑

| Drive 경로 | 로컬 경로 |
|---|---|
| `{폴더}/01_강의 자료/*` | `{폴더}/자료/*` |
| `{폴더}/02_강의 코드/*` | `{폴더}/강의코드/*` |
| `{폴더}/03_실습 코드/*` | `{폴더}/실습코드/*` |
| `{폴더}/강의코드/*` | `{폴더}/강의코드/*` |
| `{폴더}/실습코드/*` | `{폴더}/실습코드/*` |
| `{폴더}/자료/*` | `{폴더}/자료/*` |
| 그 외 하위폴더 | 폴더명 그대로 유지 |

## 관련 파일

- 빠른 동기화 스크립트: `sync_drive.py`
- 드라이브 상태 스냅샷: `.drive_state.json`
- 상세 워크플로 문서: `WORKFLOW.md`
- rclone remote: `play_data:`
- Drive root folder ID: `1lpBA7hXCIQhNgYkrF_qxieyqcCkjKMj4`
