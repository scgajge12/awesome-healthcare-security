# 🔬 ラボ、コミュニティ、情報共有組織

医療セキュリティに取り組む研究室、業界団体、コミュニティをまとめる。
この分野は研究者と臨床現場の距離が近く、コミュニティを通じて実務の知見が流通する傾向がある。

> [!NOTE]
> **表記ルール**：本ページでは、**事実**（一次情報で確認できる内容。出典を併記する）、**報道ベース**（報道のみで確認でき、当事者の公表資料では裏付けが取れていない内容）、**分析**（筆者の解釈）を書き分ける。
> 出典は、当事者の公表資料、行政文書、CVE、ベンダアドバイザリなどの一次情報を優先して示す。

---

## 研究機関、ラボ

| 組織 | 所在 | 概要 |
|---|---|---|
| [Health and Medical Security Lab（HMS Lab）](https://isi.jhu.edu/health-and-medical-security/) | Johns Hopkins University Information Security Institute（米国） | 医療、ヘルスケア領域のセキュリティを扱う研究ラボ |
| [Archimedes Center for Health Care and Medical Device Cybersecurity](https://www.secure-medicine.org/) | 米国 | 医療機器セキュリティの研究と、業界向けトレーニングを行う |
| [SUTD ASSET Research Group](https://asset-group.github.io/) | シンガポール | SweynTooth をはじめとする無線プロトコルの脆弱性研究 |

> [!NOTE]
> 掲載は公開されている情報に基づく。
> 研究室の体制や活動内容は変わりうるため、詳細は各組織の公式サイトを確認してほしい。
> 追加すべき研究室があれば [Issue](https://github.com/scgajge12/awesome-healthcare-security/issues) で教えてほしい。

---

## 情報共有組織（ISAC など）

| 組織 | 対象地域 | 概要 |
|---|---|---|
| [一般社団法人医療 ISAC](https://m-isac.jp/) | 日本 | 国内の医療機関を対象とした脅威情報の共有と支援 |
| [一般社団法人医療サイバーセキュリティ協議会（MedCSC）](https://medcsc.org/) | 日本 | セミナー、ワークショップ、人材の実践的トレーニングとインシデント訓練、リスク可視化ツールの提供 |
| [Health-ISAC](https://health-isac.org/) | 国際 | 医療分野の国際的な情報共有組織。[日本語ページ](https://health-isac.org/ja/)がある |
| [HHS HC3](https://www.hhs.gov/about/agencies/asa/ocio/hc3/index.html) | 米国 | 保健福祉省による医療分野向け脅威分析 |
| [HSCC Cybersecurity Working Group](https://healthsectorcouncil.org/) | 米国 | 官民連携による医療分野のセキュリティ指針策定 |
| [HHS 405(d) Program](https://405d.hhs.gov/) | 米国 | 規模別の実践集 HICP と、医療従事者向けの教材を提供 |
| [ENISA](https://www.enisa.europa.eu/) | EU | EU の医療分野を含む脅威分析 |

---

## 業界団体、標準化団体

規格や開示様式は、これらの団体が作っている。
医療機器や医療情報システムを調達、評価するときに、根拠として引く先になる。

| 組織 | 所在 | 概要 |
|---|---|---|
| [一般社団法人保健医療福祉情報システム工業会（JAHIS）](https://www.jahis.jp/) | 日本 | 医療情報システムの業界団体。JAHIS 標準と、医療情報セキュリティ開示書（MDS、SDS）のガイドを公表 |
| [一般社団法人日本医療機器産業連合会（医機連）](https://www.jfmda.gr.jp/) | 日本 | 医療機器の業界団体。製造販売業者向けと医療機関向けのサイバーセキュリティ手引書を編集 |
| [一般社団法人日本画像医療システム工業会（JIRA）](https://www.jira-net.or.jp/publishing/security.html) | 日本 | 画像医療システムの業界団体。セキュリティ刊行物と MDS2 の解説を公開 |
| [一般財団法人医療情報システム開発センター（MEDIS-DC）](https://www.medis.or.jp/) | 日本 | 標準マスターの整備と、HPKI カードを発行する認証局の運営 |
| [特定非営利活動法人日本医療 AI リテラシー協会（JAMAIL）](https://jamail.or.jp/) | 日本 | 医療 AI の教育と人材育成。オンラインコミュニティ AcademiX Medical を運営 |
| [日本デジタルヘルス・アライアンス（JaDHA）](https://jadha.jp/) | 日本 | デジタルヘルス領域の団体。AISI と連携し、ヘルスケア領域の AI セーフティ評価観点ガイドの策定に参加 |
| [AAMI](https://aami.org/) | 米国 | 医療機器の規格団体。TIR57（セキュリティリスクマネジメント）、TIR97（市販後管理）を発行 |
| [NEMA / MITA](https://www.nema.org/) | 米国 | 全米電機製造業者協会と、その医用画像部門（MITA）。DICOM と MDS2 の策定に関与 |
| [ECRI](https://home.ecri.org/) | 国際 | 医療技術の安全性評価を行う非営利組織。年次の Top 10 Health Technology Hazards を公表 |
| [IHE International](https://www.ihe.net/) | 国際 | 医療情報の相互運用性プロファイルを策定。監査証跡と利用者認証（ATNA）などのセキュリティプロファイルを含む |

---

## コミュニティ、カンファレンス

| 名称 | 概要 |
|---|---|
| [Biohacking Village](biohacking-village.md) | DEF CON 内の医療、バイオセキュリティコミュニティ。実機の医療機器を対象にした Device Lab を開催する。2024 年からは日本の CODE BLUE でも開催されている（[公式サイト](https://villageb.io/)） |
| [CyberMed Summit](https://www.cybermedsummit.org/) | 医師とセキュリティ研究者が合同で行う、臨床シミュレーション形式のカンファレンス |
| [I Am The Cavalry](https://iamthecavalry.org/) | 生命に関わる分野のセキュリティを扱う草の根組織。医療機器向けの原則を提唱している |
| [HIMSS](https://www.himss.org/) | 医療 IT の国際的な業界団体。セキュリティ関連の調査、標準（MDS2 など）に関与 |
| [日本医療情報学会](https://www.jami.jp/) | 国内の医療情報分野の学会。医療情報技師の認定を行う |

Biohacking Village の Device Lab は、メーカーが実機を持ち込み、研究者が合法的に検証できる場として機能している。
医療機器の検証を実践的に学ぶ機会として、この分野では特異な位置を占める。
国内では、CODE BLUE の併設ビレッジとして 2024 年から開催されている。

DEF CON と CODE BLUE の双方について、[Biohacking Village（DEF CON、CODE BLUE）](biohacking-village.md)にまとめている。

---

## 隣接する領域

- [サイバーバイオセキュリティ](cyberbiosecurity.md)：合成核酸の調達で供給側が行う確認、研究部門の情報システム、配列データの取り扱い

---

## 関連ページ

- [学習リソース](../resources/learning.md)
- [論文、レポート](../resources/research.md)

---

<sub>[トップへ](../../../README.md)</sub>
