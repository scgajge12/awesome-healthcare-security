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

# Why not: 次の五点は URL 側の問題ではないため、除外や許可で黙らせる。
# 一律に除外を増やすと本当のリンク切れを見落とすので、理由を書けるものだけを対象にする。
#
# - m-isac.jp：サーバ証明書が *.xbiz.ne.jp のみを含み、ホスト名と一致しない。
#   サイトは稼働しているため、証明書が直るまで除外する。
# - imdrf.org：HTTP/2 の応答が lychee の実装と噛み合わず、毎回失敗する。
# - fda.gov, mri.co.jp：自動アクセスを bot 検知に回し、ブラウザでは開くページに 404 や
#   apology ページへの 302 を返す。URL の誤りと区別できないため除外し、これらのリンクは
#   サイト改編の告知や検索結果で追う。
# - github.com の stargazers：README のバッジのリンク先。スター数が 0 のリポジトリでは
#   GitHub がこのページに 404 を返すため、リンクが正しくても失敗する。
# - accept に 202 を含めるのは、hl7.org が自動アクセスに 202 を返すため。
#
# 政府機関や医療機関のサイトは自動アクセスに 403, 429 を返すことがあるため、
# これらも到達可能として扱う。
# 並列度を 4 に落としているのは、同時接続が多いと bot 検知に回すサイトがあるため。
lychee \
  --no-progress \
  --accept 200,202,206,403,429 \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0 Safari/537.36" \
  --exclude '^https?://(www\.)?m-isac\.jp' \
  --exclude '^https?://(www\.)?imdrf\.org' \
  --exclude '^https?://(www\.)?fda\.gov' \
  --exclude '^https?://(www\.)?mri\.co\.jp' \
  --exclude '^https?://(www\.)?github\.com/[^/]+/[^/]+/stargazers/?$' \
  --max-concurrency 4 \
  --cache \
  --max-cache-age 1d \
  "${targets[@]}"
