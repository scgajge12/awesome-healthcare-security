#!/usr/bin/env bash
# 本リポジトリの Markdown に対して、機械的に検出できる規範違反を洗い出す。
# 検出結果は候補であり、そのまま違反とは限らない。固有名詞の内部の中黒、
# 英語表記のダッシュ、コードブロックの内容は対象外である。目視で判断する。
#
# 使い方: bash skills/repo-review/scripts/check.sh [対象パス...]
#   引数を省略するとリポジトリ全体を対象にする。

set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 1

TARGETS=("$@")
if [ ${#TARGETS[@]} -eq 0 ]; then
  TARGETS=(README.md docs monthly-reports)
fi

# 英語ページと、規範そのものを説明しているファイルは対象から外す
EXCLUDE='README-en\.md|CLAUDE\.md|CONTRIBUTING\.md|skills/'

section() { printf '\n\033[1m== %s ==\033[0m\n' "$1"; }
report() {
  local out
  out=$(cat)
  if [ -n "$out" ]; then
    echo "$out"
  else
    echo "検出なし"
  fi
}

section "ダッシュ（日本語の地の文と見出しでは使わない）"
grep -rn "—\|――" --include="*.md" "${TARGETS[@]}" 2>/dev/null | grep -Ev "$EXCLUDE" | report

section "中黒（並列には使わない。固有名詞の内部は許容）"
grep -rn "・" --include="*.md" "${TARGETS[@]}" 2>/dev/null | grep -Ev "$EXCLUDE" | report

section "LLM 的な空虚表現"
grep -rnE "重要なのは|不可欠|極めて|非常に|大いに|掘り下げ|多角的|包括的|正面から|に他ならない|と言えるだろう" \
  --include="*.md" "${TARGETS[@]}" 2>/dev/null | grep -Ev "$EXCLUDE" | report

section "文体の不統一（本文は「である」調。依頼と手順の指示文は除く）"
grep -rn "です。\|ます。\|ません。\|でしょう。" --include="*.md" "${TARGETS[@]}" 2>/dev/null \
  | grep -Ev "$EXCLUDE" | grep -v "ください。" | grep -v "ほしい。" | report

section "「事実」ブロックと出典の対応（目視で確認する）"
for f in $(grep -rl "^\*\*事実\*\*" --include="*.md" "${TARGETS[@]}" 2>/dev/null | grep -Ev "$EXCLUDE"); do
  facts=$(grep -c "^\*\*事実\*\*" "$f")
  links=$(grep -c "http" "$f")
  printf '%s : 事実ブロック %s 件 / リンク %s 件\n' "$f" "$facts" "$links"
done | report
echo "各事実ブロックに対応する出典が示されているかは、目視で確認する。"

section "図のないページ（構造や流れを扱うページには図を検討する）"
for f in $(find "${TARGETS[@]}" -name "*.md" 2>/dev/null | grep -Ev "$EXCLUDE"); do
  if ! grep -q '```mermaid\|<img src=.*\.svg' "$f"; then
    echo "$f"
  fi
done | report

printf '\n'
echo "検出結果は候補である。各項目を目視で確認し、規範に照らして判断する。"
