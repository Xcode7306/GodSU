#!/bin/bash
# 用法: render.sh <input.html> <output.pdf>
# 无头 Chrome 渲染 A4 PDF 并报告页数
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "用法: render.sh <input.html> <output.pdf>" >&2
  exit 2
fi

IN="$1"
OUT="$2"

if [ ! -f "$IN" ]; then
  echo "找不到输入 HTML: $IN" >&2
  exit 1
fi

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ ! -x "$CHROME" ]; then
  CHROME="$(command -v chromium 2>/dev/null || true)"
fi
if [ -z "$CHROME" ]; then
  CHROME="$(command -v google-chrome 2>/dev/null || true)"
fi
if [ -z "$CHROME" ] || [ ! -x "$CHROME" ]; then
  echo "找不到可执行的 Google Chrome、Chromium 或 google-chrome。" >&2
  exit 1
fi

OUT_DIR="$(dirname "$OUT")"
mkdir -p "$OUT_DIR"
IN_DIR="$(CDPATH= cd -- "$(dirname "$IN")" && pwd)"
IN_FILE="$(basename "$IN")"

"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$OUT" "file://$IN_DIR/$IN_FILE" >/dev/null 2>&1

python3 - "$OUT" <<'EOF'
import re, sys
data = open(sys.argv[1], 'rb').read()
pat = rb'/Type\s*/Page[^s]'
pages = len(re.findall(pat, data))
print(f"OK {sys.argv[1]}  pages={pages}  bytes={len(data)}")
EOF
