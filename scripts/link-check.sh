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
# - h.u-tokyo.ac.jp：サーバが中間証明書を返さず、検証が「unable to verify the first
#   certificate」で止まる。ブラウザは自前で補完するため開けるが、curl と lychee は失敗する。
#   東京大学医学部附属病院の公式ドメインであることは大学のサイトからの導線で確認できる。
#   証明書の配信が直るまで除外する。
# - miekosei.or.jp：h.u-tokyo.ac.jp と同じく中間証明書を返さない。JA 三重厚生連の公式
#   ドメインであることは、WebFetch で取得した本文（県内 6 病院と 1 診療所を運営）で確認した。
# - chc1.com：ブラウザ以外からの取得に 503 を返す。lychee と WebFetch のどちらでも同じで、
#   当該医療機関の公式ドメインであることは HHS OCR の届出と一致する。
# - bannerhealth.com：自動アクセスへ 403 を返し、応答ヘッダが肥大して HTTP/2 の扱いが
#   lychee と噛み合わない。curl でも 403、WebFetch は「Header overflow」で止まる。
# - med.kagawa-u.ac.jp、psyche-niigata.jp：TLS の折衝が lychee 側で HandshakeFailure に
#   なる。curl では 200 が返り、内容も香川大学医学部と新潟県立精神医療センターの公式
#   サイトであることを確認した。
# - ssl4.eir-parts.net：TDnet の開示 PDF を配信するサーバ。lychee は TLS handshake failed で
#   止まるが、取得した PDF がリニカルの 2021 年 12 月 6 日付の開示であることを確認した。
# - geisinger.org：自動アクセスを 302 で回し続け、lychee が追いきれない。WebFetch では
#   本文が取れる。
# - dxs-systems.com：接続はできるが、自動アクセスへ本文を返さないまま切断する。
# - drk-khg.de：日本からの接続が確立できない。union.health, kch.or.kr と同じ挙動で、
#   ブラウザでも開けないが、DRK Trägergesellschaft Süd-West の公式ドメインであることは
#   検索エンジンが /ueber-uns や /standorte/kliniken を索引していることで確認できる。
#   到達性が戻ったら除外を外す。
# - ccss.sa.cr、ch-versailles.fr、ch-armentieres.fr、ajh.org：--timeout 60 と 4 回の再試行を
#   かけても毎回タイムアウトまたは接続拒否になる。eur-lex.europa.eu などと違い待ち方の
#   調整では通らない。いずれも当該医療機関の公式ドメインで、検索エンジンが下位ページ
#   （ch-versailles.fr/0/1/34/68、ccss.sa.cr/portal、ajh.org/about など）を索引している。
#   国外からの自動アクセスを絞っていると見られるため、URL の誤りとは区別して除外する。
# - baxter.com：応答が lychee の HTTP/2 の扱いと噛み合わず「HTTP/2 protocol error」で
#   止まる。curl では 200 が返り、内容も Baxter International の公式サイトである。
# - nychealthandhospitals.org：Radware の bot 管理が自動アクセスを検証用の外部ドメインへ
#   302 で回すため、lychee がリダイレクトを追い切れない。geisinger.org と同じ挙動で、
#   curl では最終的に 200 が返る。ニューヨーク市保健病院公社の公式ドメインである。
# - cch.org.tw：lychee は接続を確立できないと報告するが、curl では 200 が返る。証明書の
#   subject が Changhua Christian Hospital、subjectAltName が *.cch.org.tw であることも
#   確認した。彰化基督教醫院の公式ドメインである。
# - marinomed.com：apex と www のどちらも、TLS の折衝の途中で接続が切られる。curl でも
#   WebFetch でも同じで、drk-khg.de と同様に国外からの接続を絞っていると見られる。
#   参照先が Marinomed Biotech のアドホック開示のページであることは、検索エンジンが同じ
#   URL を索引していること、および EQS 経由の同日の開示が金融メディアに転載されている
#   ことで確認できる。
# - pharmerica.com：www は 301 で apex へ回る。apex は 141.193.213.20 と .21 に解決し、
#   WebFetch では本文（PharMerica Corporation の長期ケア薬局サービス）が取れるが、lychee は
#   接続を確立できない。本文が返ることを確認できたため、リンクを apex に直したうえで除外する。
# - fmu.ac.jp：www.fmu.ac.jp は CNAME で lb.48h08j5c19vil51e.4.d-16.jp を指すが、その名前に
#   A レコードがない（IIJ の管理 DNS が SOA だけを返す NODATA）。名前解決が住所まで届かないため、
#   lychee も curl も WebFetch も到達できない。福島県立医科大学の公式ドメインであることは、
#   検索エンジンが /univ/daigaku/ や /hospitals/hikarigaoka/ を索引していることで確認できる。
#   先方の DNS の不具合であって URL の誤りではないため除外する。上記の各例と違い、恒常的な
#   アクセス制限ではなく復旧しうる障害なので、A レコードが戻ったら除外を外す。
#   確認は `dig +short www.fmu.ac.jp` で A レコードが返るかを見る。
# - nhls.ac.za：h.u-tokyo.ac.jp と同じく中間証明書を返さない。lychee は接続失敗として
#   報告し、WebFetch は「unable to verify the first certificate」で止まる。南アフリカ国立
#   衛生検査機構の公式ドメインであることは、併記した South African Medical Journal の論文が
#   同機構への攻撃を扱っていることで確認できる。証明書の配信が直るまで除外する。
# - umc.edu：自動アクセスを接続段階で弾き、--timeout 60 と 4 回の再試行でも「Connection
#   failed」で止まる。ミシシッピ大学医療センターの公式ドメインであることは、WebFetch で
#   本文（州で唯一の学術医療センターである旨の告知）が取れることで確認した。到達性が戻ったら
#   除外を外す。
# - oppc.com：umc.edu と同じく自動アクセスを接続段階で弾く。OnePoint Patient Care の公式
#   ドメインであることは、WebFetch で本文が取れること、および HHS OCR の届出と一致することで
#   確認した。到達性が戻ったら除外を外す。
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
  --exclude '^https?://(www\.)?h\.u-tokyo\.ac\.jp' \
  --exclude '^https?://(www\.)?miekosei\.or\.jp' \
  --exclude '^https?://(www\.)?bannerhealth\.com' \
  --exclude '^https?://(www\.)?med\.kagawa-u\.ac\.jp' \
  --exclude '^https?://(www\.)?psyche-niigata\.jp' \
  --exclude '^https?://ssl4\.eir-parts\.net' \
  --exclude '^https?://(www\.)?geisinger\.org' \
  --exclude '^https?://(www\.)?dxs-systems\.com' \
  --exclude '^https?://(www\.)?drk-khg\.de' \
  --exclude '^https?://(www\.)?ccss\.sa\.cr' \
  --exclude '^https?://(www\.)?ch-versailles\.fr' \
  --exclude '^https?://(www\.)?ch-armentieres\.fr' \
  --exclude '^https?://(www\.)?ajh\.org' \
  --exclude '^https?://(www\.)?baxter\.com' \
  --exclude '^https?://(www\.)?nychealthandhospitals\.org' \
  --exclude '^https?://(www\.)?cch\.org\.tw' \
  --exclude '^https?://(www\.)?marinomed\.com' \
  --exclude '^https?://(www\.)?pharmerica\.com' \
  --exclude '^https?://(www\.)?fmu\.ac\.jp' \
  --exclude '^https?://(www\.)?nhls\.ac\.za' \
  --exclude '^https?://(www\.)?umc\.edu' \
  --exclude '^https?://(www\.)?oppc\.com' \
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
