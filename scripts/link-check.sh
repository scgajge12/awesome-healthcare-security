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

# 全 .md を対象にすると 2000 リンク超を数分かけて確認するため、何も出ないと
# 停止しているのか進んでいるのか判断できない。端末なら進捗バーを出す。
# Why not: 進捗バーと色を一つの判定でまとめない。進捗バーは標準エラーへ、結果は
# 標準出力へ出るため、`link-check.sh | tee log` のときは前者を端末に出したまま
# 後者だけを制御文字なしでログに残したい。判定はそれぞれの出力先で行う。
# LINK_CHECK_VERBOSE=1 を付けると、1 リンクごとの結果も流れる。
report_args=()
if [ -t 2 ]; then
  report_args+=(--no-progress=false)
else
  report_args+=(--no-progress)
fi
if [ -t 1 ]; then
  report_args+=(--mode color)
else
  report_args+=(--mode plain)
fi
if [ "${LINK_CHECK_VERBOSE:-}" = "1" ]; then
  report_args+=(--verbose)
fi

# Why not: 開始と終了の行は標準エラーではなく標準出力へ出す。`| tee log` としたとき、
# 結果と同じログに残ってほしいのはこの二行だからである。
started_at=$SECONDS
echo "link-check: $(date '+%H:%M:%S') 開始、${#targets[@]} ファイルを確認する"

# Why not: 次の各点は URL 側の問題ではないため、除外や許可で黙らせる。
# 一律に除外を増やすと本当のリンク切れを見落とすので、理由を書けるものだけを対象にする。
#
# - m-isac.jp：サーバ証明書が *.xbiz.ne.jp のみを含み、ホスト名と一致しない。
#   サイトは稼働しているため、証明書が直るまで除外する。
# - union.health, kch.or.kr：443 への接続が拒否またはタイムアウトする。上記の各例と違い
#   ブラウザでも開けないが、いずれも当該医療機関の公式ドメインであることは、検索エンジンの
#   索引と医療機関検索サイトの掲載で確認できる。日本からの接続を制限していると見られるため、
#   URL の誤りとは区別して除外する。到達性が戻ったら除外を外す。
# - imdrf.org, sophos.com, cyber.gov.au, digitalhealth.gov.au：HTTP/2 の応答が lychee の
#   実装と噛み合わず、毎回失敗する。ブラウザと WebFetch では開けるため、URL 側の問題ではない。
# - fda.gov, mri.co.jp：自動アクセスを bot 検知に回し、ブラウザでは開くページに 404 や
#   apology ページへの 302 を返す。URL の誤りと区別できないため除外し、これらのリンクは
#   サイト改編の告知や検索結果で追う。
# - i2b2.org：前段の Varnish が自動アクセスへ HTTP 781 という非標準の状態行を返す。
#   accept に並べても他サイトの本当の異常まで通してしまうため、ホスト単位で除外する。
#   ブラウザと WebFetch では開き、更新も続いている。community.i2b2.org は 200 を返すので
#   除外の対象に含めず、確認を続ける。
# - developer.android.com：自動アクセスを Google のサインイン（prompt=none）へ回し、
#   元の URL とサインインの間を往復する。lychee は 10 回追ってもページ本文に届かない。
#   WebFetch では 200 で本文が取れるため、URL 側の問題ではない。ホスト全体が同じ挙動に
#   なるので、パス単位では切り分けられず、ホストごと除外する。
# - chc1.com：ブラウザ以外からの取得に 503 を返す。lychee と WebFetch のどちらでも同じで、
#   当該医療機関の公式ドメインであることは HHS OCR の届出と一致する。
# - github.com の stargazers：README のバッジのリンク先。スター数が 0 のリポジトリでは
#   GitHub がこのページに 404 を返すため、リンクが正しくても失敗する。
# - accept に 202 を含めるのは、hl7.org が自動アクセスに 202 を返すため。
#
# 政府機関や医療機関のサイトは自動アクセスに 403, 429 を返すことがあるため、
# これらも到達可能として扱う。
#
# Why not: eur-lex.europa.eu, europol.europa.eu, picscheme.org, linddun.org のような
# 公的機関や学術系のサイトは、URL が正しくてもタイムアウト、502、接続断で失敗する。
# ブラウザでは開けるため URL 側の問題ではないが、除外すると本当のリンク切れまで
# 見落とすので、除外ではなく待ち方の調整で対処する。
# --host-concurrency 1 で同一ホストへの同時接続をやめ、--timeout と再試行を延ばす。
# 同時接続が多いと bot 検知に回すサイトへの配慮は --host-concurrency 1 が担うため、
# 全体の並列度は 8 まで戻して、ホストをまたぐ確認は速く進める。
# lychee は失敗も .lycheecache に載せるため、一度の失敗が同じ URL の他の出現箇所へ
# 「Error (cached)」として波及する。一時的な応答はキャッシュに残さない。
lychee \
  "${report_args[@]}" \
  --accept 200,202,206,403,429 \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0 Safari/537.36" \
  --exclude '^https?://(www\.)?m-isac\.jp' \
  --exclude '^https?://(www\.)?union\.health' \
  --exclude '^https?://(www\.)?kch\.or\.kr' \
  --exclude '^https?://(www\.)?imdrf\.org' \
  --exclude '^https?://(www\.)?sophos\.com' \
  --exclude '^https?://(www\.)?fda\.gov' \
  --exclude '^https?://(www\.)?mri\.co\.jp' \
  --exclude '^https?://(www\.)?i2b2\.org' \
  --exclude '^https?://(www\.)?cyber\.gov\.au' \
  --exclude '^https?://(www\.)?digitalhealth\.gov\.au' \
  --exclude '^https?://developer\.android\.com' \
  --exclude '^https?://(www\.)?chc1\.com' \
  --exclude '^https?://(www\.)?github\.com/[^/]+/[^/]+/stargazers/?$' \
  --max-concurrency 8 \
  --host-concurrency 1 \
  --timeout 60 \
  --max-retries 4 \
  --retry-wait-time 5 \
  --cache \
  --cache-exclude-status '429,500..504' \
  --max-cache-age 1d \
  "${targets[@]}"
status=$?

echo "link-check: $(date '+%H:%M:%S') 終了、$((SECONDS - started_at)) 秒、終了コード ${status}"
exit "$status"
