#!/bin/bash

ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "=== sk_network 학습 뷰어 시작 ==="

# 1. nbconvert 확인
if ! python -c "import nbconvert" 2>/dev/null; then
  echo "nbconvert 설치 중..."
  pip install nbconvert
fi

# 2. npm 패키지 확인
if [ ! -d "$ROOT/website/node_modules" ]; then
  echo "npm 패키지 설치 중..."
  cd "$ROOT/website" && npm install
fi

# 3. 빌드 + watch 모드 백그라운드 실행
echo ""
echo "노트북 변환 중 (처음에만 시간이 걸립니다)..."
python "$ROOT/website/scripts/build_content.py" --watch &
WATCH_PID=$!

# 4. 빌드 완료 대기 (manifest.json 생성될 때까지)
while [ ! -f "$ROOT/website/public/content/manifest.json" ]; do
  sleep 1
done

# 5. Vite 개발 서버 실행
echo ""
echo "브라우저를 여는 중..."
cd "$ROOT/website" && npx vite --open &
VITE_PID=$!

# Ctrl+C 시 두 프로세스 모두 종료
trap "kill $WATCH_PID $VITE_PID 2>/dev/null; echo ''; echo '종료됨'; exit" INT

echo ""
echo "✅ 실행 중 — 종료하려면 Ctrl+C"
wait
