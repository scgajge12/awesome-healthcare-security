# 本リポジトリの執筆方針

医療業界とサイバーセキュリティに関する知見をまとめた公開リポジトリである。
対象は、病院などの医療機関と、製薬企業の双方とする。
文書を追加、修正する際は、以下に従う。

## 前提

本リポジトリは**公開リポジトリ**である。
次の情報は掲載しない。

- 未公表のインシデント情報、当事者が公表していない被害の詳細
- 実在する患者の情報、それを含むスクリーンショットやログ
- 未修正の脆弱性の詳細（責任ある開示の手続きを経ていないもの）
- そのまま攻撃に使える実装コード、エクスプロイト
- 特定の組織や個人を非難する記述
- 執筆者や関係者の連絡先などの個人情報（公開されているプロフィールへのリンクを除く）

## レビュー

文書を追加または編集したら、[`skills/repo-review/SKILL.md`](skills/repo-review/SKILL.md) の手順でレビューする。
一次情報、事実と推測の分離、文章規範、公開適格性、構成の整合、図解の六つの観点で確認する。

## 一次情報

記述の出所を必ず示す。

- 事実として書く各項目に、出典を併記する
- 出典は一次情報を優先する（当事者の公表資料、行政文書、CVE、ベンダアドバイザリ、調査報告書）
- 報道だけを根拠にする記述は「報道ベース」と明示する
- 出典を確認できない記述は、削除するか「未確認」と明記する
- 数値（被害人数、金額、期間）は出所を示す
- CVE 番号は、NVD で実在と内容を確認してから書く

## 図解

構造と因果は、文章だけで説明せず図で示す。

| 手段 | 適する対象 |
|---|---|
| Mermaid | 関係、流れ、階層、シーケンス |
| SVG（`assets/` に置き `<img>` で参照する） | バイト構造、層の重なり、位置関係が意味を持つ図 |
| コードブロック | ディレクトリ構成、コマンド出力 |

SVG は明色と暗色の両テーマで読めるようにする（`@media (prefers-color-scheme: dark)` を SVG 内の `<style>` に書く）。
GitHub は Markdown 中のインライン `<svg>` を除去するため、ファイルとして置いて参照する。

## 文章の規範

日本語文書は、[`skills/japanese-tech-writing/SKILL.md`](skills/japanese-tech-writing/SKILL.md) に定めた文章規範に従って執筆し、校正する。

文書を新規作成または編集したあとは、必ずこの規範に照らして校正すること。
特に次を確認する。

- 一文ごとに改行し、段落は空行で区切る
- 日本語の地の文と見出しでダッシュ（`—` `――`）を使わない
- 並列に中黒（`・`）を使わない。読点で書く。固有名詞の内部での使用は問題ない
- 用語と定義の箇条書きは「**用語**：説明」の形にする
- 太字は論理の要所に限る
- LLM 的な空虚な表現を使わない（「重要なのは〜である」「〜の観点から」「不可欠」「極めて」「非常に」「掘り下げる」など）
- 同じ主張を言い換えて繰り返さない
- 見出しは内容を特定する句にする
- 因果を主張するときは、その機構を一文で示す
- 検出や解決を「必ずできる」かのように書かない

## 内容の規範

- **事実と推測を分ける**：「事実」「報道ベース」「分析」を書き分ける
- **一次情報にリンクする**：報道の二次引用ではなく、公表資料、行政文書、CVE、ベンダアドバイザリを優先する
- **帰属を断定しない**：攻撃グループの特定は、当事者または公的機関の公表に基づく場合のみ記載する
- **防御に資する形で書く**：攻撃手法は、検知、緩和策とセットで記述する

## 構成

| パス | 内容 |
|---|---|
| `README.md` / `README-en.md` | 日本語版と英語版のトップページ。両方を同期させる |
| `docs/threats/incidents/` | インシデント事例。履歴は地域ごと（`japan/YYYY-timeline.md`、`global/YYYY-timeline.md`）、その年の情勢は国内と海外を統合して `years/YYYY-summary.md` に置く。米国 HHS OCR の届出は制度軸として `global/YYYY-us-hhs.md` に全件集計を置く |
| `docs/threats/incidents/research-tips.md` | 事例の調べ方（情報源、手順、落とし穴） |
| `docs/threats/incidents/report-reading.md` | 調査報告書から攻撃の流れを復元する（取り出す欄、欠落の扱い） |
| `docs/threats/actors/` | 脅威アクターと TTPs |
| `docs/threats/statistics/` | 公的統計から読む脅威（日本、海外） |
| `docs/threats/integrity-attacks.md` | 完全性への攻撃と患者安全（改変の経路、検知の設計） |
| `docs/technology/medical-devices/` | 医療機器（IoMT、PACS）のセキュリティ |
| `docs/technology/oss-vulnerabilities/` | OSS 医療情報システムの脆弱性 |
| `docs/technology/web-security/` | 医療系 Web アプリケーションのセキュリティ |
| `docs/technology/cloud/` | クラウド事業者と医療（AWS、Google Cloud、Azure、さくらインターネット） |
| `docs/technology/dx-ax/` | 医療 DX と AX（国の基盤と接続点、医療における AI のセキュリティ） |
| `docs/technology/digital-health/` | デジタルヘルス（規制の当たり方、攻撃面、Google のデジタルヘルス） |
| `docs/technology/genomics.md` | ゲノムデータの保護（所在、二次利用、事業者が消えるときの扱い） |
| `docs/technology/identity.md` | 認証とアクセス管理（二要素認証の要求と期限、ID の棚卸し、ブレークグラス） |
| `docs/technology/logging.md` | ログと監視の設計（何を残すか、保存期間、読む仕組み） |
| `docs/technology/detection-engineering.md` | 検知の設計を技法単位に落とす（観測点、条件、医療の正常系、欺瞞とカナリア） |
| `docs/technology/credential-exposure.md` | 外に出た認証情報（流出の経路、確認の手順、失効の順序） |
| `docs/technology/email-domain.md` | メールとドメインの管理（送信ドメイン認証、失効ドメイン、BEC） |
| `docs/technology/media-disposal.md` | 記憶媒体の廃棄と機器の下取り（消去、証跡、中古市場） |
| `docs/technology/segmentation.md` | ネットワークの分離（ゾーンモデル、到達性の確認、例外の管理） |
| `docs/practice/threat-modeling.md` | 医療の脅威モデリング（信頼境界、STRIDE、攻撃ツリー、順序づけ） |
| `docs/practice/attack-surface.md` | 外部から見た自組織の攻撃面（棚卸し、測り方の線引き、継続） |
| `docs/practice/legal-boundary.md` | 検証と調査の法的境界（条文、立場ごとの線、許諾の文面、報告の経路） |
| `docs/practice/pentest/` | セキュリティ診断とペネトレーションテスト（医療機関、製薬企業、医療機器）。`htb-style-hospital.md` は演習環境の攻略の型を病院に当てはめた読み替えと、商用メニューとの対応 |
| `docs/practice/bug-bounty/` | バグバウンティと脆弱性開示（医療分野） |
| `docs/response/` | インシデント対応と事業継続（サイバー BCP、基盤の構えと外部依存、演習シナリオ）。初動、ダウンタイム運用、届出、復旧は順次追加する |
| `docs/guidelines/` | ガイドラインと法規制 |
| `docs/governance/` | 経営とガバナンス（体制、経営層への報告、予算、リスク移転） |
| `docs/reference/pharma/` | 製薬企業のセキュリティ（治験と研究データ、製造 OT、原薬と受託製造） |
| `docs/reference/labs-communities/` | ラボ、コミュニティ |
| `docs/reference/resources/` | ツール、論文、研究テーマ、学習リソース、リークサイト横断フィード |
| `docs/reference/security-services/` | セキュリティサービスのカタログ（区分と選び方、国内、海外）。掲載は推奨ではない |
| `docs/reference/security-basics.md` | セキュリティの基礎（7 要素、設計の原則、脅威モデリング、検知と対応） |
| `docs/reference/ethics.md` | 医療の倫理とセキュリティの倫理（概念、特徴、考え方の違い） |
| `docs/reference/ai-agent.md` | AI エージェントから使う（取り込み方、構造の渡し方、聞き方、生成物の確かめ方、更新の追い方） |
| `docs/reference/GLOSSARY.md` | 用語集 |
| `docs/reference/_templates/` | 事例追加用のテンプレート |
| `monthly-reports/` | 月報。`YYYY/YYYY-MM.md` の形式で追加する |
| `skills/` | 本リポジトリ用のレビュースキル |
| `scripts/` | リンク切れ確認のスクリプト（`link-check.sh`） |
| `.githooks/` | コミット前に走らせるフック（`git config core.hooksPath .githooks` で有効化） |
| `assets/` | 図（SVG） |

`docs/` は七つの群に分かれる。
**threats**：脅威を知る。
**technology**：守る対象と攻撃面を、システムの種類ごとに扱う。
**practice**：設計段階の脅威の数え上げから、攻撃面の把握、検証、報告の受け取りまでを扱う。
**response**：侵害が起きたあとの初動、診療の継続、届出、復旧を扱う。
**guidelines**：規制と業界ガイドラインを扱う。
**governance**：体制、権限、予算、経営層への報告を扱う。
**reference**：製薬固有の領域と、横断して引く参照材を置く。

各群の直下に README.md を置き、その群が何を扱うかと配下へのリンクを示す。
新しいページを追加したら、群の README.md と、`README.md` と `README-en.md` の両方にリンクを追加する。

## コミットメッセージ

`<絵文字> <type>(<scope>): <要約>` の形式に従う（Gitmoji + Conventional Commits）。
