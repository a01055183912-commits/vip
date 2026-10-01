#!/usr/bin/env bash
# src/app.html + src/data.js → index.html (독립 실행용) · dist/artifact.html (Artifact 게시용 본문)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist
python3 - <<'PY'
app = open('src/app.html', encoding='utf-8').read()
data = open('src/data.js', encoding='utf-8').read()
body = app.replace('/*@DATA@*/', data)
open('dist/artifact.html', 'w', encoding='utf-8').write(body)
head = '<!doctype html>\n<html lang="ko">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
open('index.html', 'w', encoding='utf-8').write(head + body.replace('<style>', '<style>\n[hidden]{display:none!important}', 1) + '\n</html>\n')
PY
echo "built index.html, dist/artifact.html"
