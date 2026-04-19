# sk_network

## 프로젝트 개요

SK Networks AI 교육 과정 학습 파일 모음. Python, SQL, 데이터 수집, Streamlit, 코딩테스트 등 학습 자료를 관리하는 레포지토리.

## 폴더 구조 규칙

```
01.python_basic/   — Python 기초
02.streamlit/      — Streamlit 웹앱
03.sql/            — SQL 학습
04.data_collection/ — 웹 크롤링/데이터 수집
05.sw_engineering/ — 소프트웨어 엔지니어링
06_data/ / 06_dp/  — 데이터 처리
70.skn1-4/         — 프로젝트 (번호 70 이상)
98.코딩테스트/      — 코딩테스트 풀이 (Baekjoon, Programmers)
99.참고자료/        — PDF 참고 도서 (SQLD, 코딩테스트 책 등)
```

### 각 강의 폴더 내 번호 규칙

| 폴더명 | 의미 |
|--------|------|
| `95_강의자료/` | 강의 PDF |
| `96_강의코드/` | 강사 제공 코드 |
| `97_실습자료/` | 실습 문제 |
| `98_실습답안/` | 실습 정답 |

### 파일명 규칙

| 패턴 | 의미 |
|------|------|
| `NN_주제.ipynb` | 강의 코드 |
| `실습NN_주제.ipynb` | 실습 문제 |
| `실습NN_주제_답안.ipynb` | 실습 정답 |
| `NN_주제(튜터용).ipynb` | 튜터용 확장 버전 |

## 웹사이트 (`website/`)

학습 파일을 웹에서 열람할 수 있는 뷰어 앱. Vite + React로 구성되며 GitHub Pages에 배포.

### 빌드 방법

```bash
# 1. 노트북 변환 + manifest 생성
pip install nbconvert
python website/scripts/build_content.py

# 2. 개발 서버 실행
cd website
npm install
npm run dev

# 3. 빌드
npm run build
```

### 배포

GitHub Actions가 main 브랜치 푸시 시 자동으로 GitHub Pages 배포.
URL: `https://jexists.github.io/sk_network/`

### 주요 파일

- `website/scripts/build_content.py` — ipynb → HTML 변환, manifest.json 생성
- `website/src/App.tsx` — 전체 레이아웃
- `website/src/components/FileTree.tsx` — 좌측 파일 트리
- `website/src/components/CompareView.tsx` — 강의코드/실습 비교 뷰
- `website/src/hooks/useManifest.ts` — manifest 로드 + 검색/필터 로직
- `website/public/content/manifest.json` — 파일 트리 메타데이터 (빌드 생성물)

## 환경 설정

- Python 3.13 (`.python-version` 파일로 관리)
- Node.js 20+
- 패키지 매니저: `uv` (Python), `npm` (Node)

## 코딩 스타일

- Python: 타입 힌트 사용
- React: TypeScript + 함수형 컴포넌트
- 한국어 주석 사용 가능
