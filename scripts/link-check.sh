#!/usr/bin/env bash
# Markdown 中のリンク切れを lychee で確認する。
# 引数に .md を渡すとそのファイルだけを、省略すると追跡下の全 .md を対象にする。
set -uo pipefail

cd "$(git rev-parse --show-toplevel)" || exit 1

if ! command -v lychee >/dev/null 2>&1; then
  echo "link-check: lychee が見つからないため確認を省略する（brew install lychee）" >&2
  exit 0
fi

targets=()
if [ "$#" -gt 0 ]; then
  for f in "$@"; do
    case "$f" in
      docs/reference/_templates/*) continue ;;
      *.md) [ -f "$f" ] && targets+=("$f") ;;
    esac
  done
else
  while IFS= read -r f; do targets+=("$f"); done < <(
    git ls-files '*.md' ':!:docs/reference/_templates/*'
  )
fi

if [ "${#targets[@]}" -eq 0 ]; then
  exit 0
fi

# 政府機関や医療機関のサイトは自動アクセスに 403, 429 を返すことがあるため、
# これらは到達可能として扱う。
lychee \
  --no-progress \
  --accept 200,206,403,429 \
  --max-concurrency 8 \
  --cache \
  --max-cache-age 1d \
  "${targets[@]}"
