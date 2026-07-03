#!/usr/bin/env bash
# Chay local server cho VietMap API Tester tren Linux / macOS
# Cach dung:
#   chmod +x start-server.sh && ./start-server.sh
#   hoac: bash start-server.sh [port]

set -e
PORT="${1:-8000}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

URL="http://localhost:${PORT}/vietmap-api-tester.html"

open_browser() {
  sleep 1
  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$URL" >/dev/null 2>&1 &
  elif command -v open >/dev/null 2>&1; then
    open "$URL" >/dev/null 2>&1 &
  else
    echo "Khong tu mo duoc trinh duyet. Hay mo thu cong: $URL"
  fi
}

echo "Dang chay server tai $URL (Ctrl+C de dung)"

if command -v python3 >/dev/null 2>&1; then
  open_browser &
  exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  open_browser &
  exec python -m http.server "$PORT"
elif command -v npx >/dev/null 2>&1; then
  open_browser &
  exec npx --yes http-server -p "$PORT"
else
  echo "Khong tim thay python3, python hoac npx (Node.js) tren may."
  echo "Hay cai Python (https://www.python.org) hoac Node.js (https://nodejs.org) roi chay lai script nay."
  exit 1
fi
