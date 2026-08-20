# 📑 論文, レポート

医療セキュリティを理解するうえで参照される研究と報告書をまとめる。

> [!NOTE]
> **表記ルール**：本ページでは、**事実**（一次情報で確認できる内容。出典を併記する）、**報道ベース**（報道のみで確認でき、当事者の公表資料では裏付けが取れていない内容）、**分析**（筆者の解釈）を書き分ける。
> 出典は、当事者の公表資料、行政文書、CVE、ベンダアドバイザリなどの一次情報を優先して示す。

---

## 医療機器セキュリティの基礎になった研究

| 文献 | 概要 |
|---|---|
| [Pacemakers and Implantable Cardiac Defibrillators: Software Radio Attacks and Zero-Power Defenses](https://www.secure-medicine.org/hubfs/public/publications/icd-study.pdf) | 植込み型除細動器の無線通信に対する攻撃と、電力を消費しない防御手法を示した研究。この分野の出発点として参照される |
| [On the (in)security of the Latest Generation Implantable Cardiac Defibrillators and How to Secure Them](https://cosicdatabase.esat.kuleuven.be/backend/publications/files/conferencepaper/2678) | 新しい世代の植込み型デバイスに対する解析と対策 |
| [Hacking Medical Devices for Fun and Insulin: Breaking the Human SCADA System](https://media.blackhat.com/bh-us-11/Radcliffe/BH_US_11_Radcliffe_Hacking_Medical_Devices_WP.pdf) | インスリンポンプに対する攻撃を示した Black Hat の研究 |
| [Security and Privacy Qualities of Medical Devices: An Analysis of FDA Postmarket Surveillance](https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0040200&type=printable) | FDA の市販後監視データから、医療機器のセキュリティ, プライバシー問題を分析した論文 |
| [ANATOMY OF AN ATTACK: MEDJACK](https://securityledger.com/wp-content/uploads/2015/06/AOA_MEDJACK_LAYOUT_6-0_6-3-2015-1.pdf) | 医療機器を足場として院内に潜伏する攻撃手法の報告 |
| [An Architecture for Analysis](https://sites.cs.ucsb.edu/~jmcmahan/research/top_picks_18.pdf) | ペースメーカーを例に、組込み機器のセキュリティ設計を論じた研究 |

---

## インシデントの一次資料

実際に起きたことを、当事者の視点で記録した文書である。
二次的な解説より、これらを直接読むほうが得るものが多い。

| 文書 | 概要 |
|---|---|
| [HSE Conti Cyber Attack Independent Post Incident Review](https://about.hse.ie/publications/conti-cyber-attack-on-the-hse-independent-post-incident-review/) | アイルランド保健サービスへの攻撃に関する詳細な事後レビュー。医療機関のインシデント対応を学ぶうえで最も充実した公開文書 |
| [NAO: Investigation - WannaCry cyber attack and the NHS](https://www.nao.org.uk/reports/investigation-wannacry-cyber-attack-and-the-nhs/) | 英国国家監査院による WannaCry の影響調査 |
| つるぎ町立半田病院 コンピュータウイルス感染事案 調査報告書 | 国内の医療機関が技術的経緯を詳細に公開した事例（[公式サイト](https://www.handa-hospital.jp/)） |
| 大阪急性期, 総合医療センター 情報セキュリティインシデント調査委員会報告書 | 委託先経由の侵入を分析した国内の事例（[公式サイト](https://www.gh.opho.jp/)） |

---

## 国内の公的研究

**事実**：厚生労働科学研究費補助金による研究の報告書は、[厚生労働科学研究成果データベース（MHLW GRANTS SYSTEM）](https://mhlw-grants.niph.go.jp/)で検索できる。
研究年度ごとの報告書が公開されるため、制度の議論に先行して行われた実証の内容を追える。

| 研究課題 | 研究代表者 | 年度 |
|---|---|---|
| [地域における共通基盤, 集中管理体制によるサイバーセキュリティの実証のための研究](https://mhlw-grants.niph.go.jp/project/180408) | 黒田知宏（京都大学医学部附属病院） | 令和 7〜8 年度 |

**事実**：上記の研究は、医療機関のセキュリティ人材の不足に対して、人材を集約した指導的な医療機関が周辺を支援する体制を構築することを目的としている。
初年度は、相互チェックの監査項目リストの策定、セキュリティチェック手順書の準備、IT-BCP 計画の策定が行われた（[研究課題の概要](https://mhlw-grants.niph.go.jp/project/180408)）。

**分析**：一施設で専任の担当者を置けないという条件は、多くの医療機関に共通する。
個々の施設の努力ではなく地域単位の共通基盤で解くという方向は、[医療 DX](../../technology/dx-ax/) の地域連携の議論と同じ前提に立っている。

---

## 業界団体系シンクタンクの調査

日本医師会総合政策研究機構（日医総研）は、医療機関のセキュリティを対象とした実態調査と提言を継続して公表している。
行政文書が「何をすべきか」を示すのに対し、これらは「現場で何ができていないか」を数字と発言で示している点で補完関係にある。

これらの数字を、攻撃者から見て何が得られる状態かという観点で読み替えた整理は [調査データから読む、備えの穴](../../governance/readiness-gaps.md) にまとめている。

| 資料 | 発行 | 内容 |
|---|---|---|
| [病院, 診療所のサイバーセキュリティ：医療機関の情報システムの管理体制に関する実態調査から（No.453）](https://www.jmari.med.or.jp/result/working/post-233/) | 2021-05-14 | 病院と診療所を対象とした大規模なアンケート調査。管理体制の整備状況を項目別に集計している |
| [医療機器に関わるサイバーセキュリティの動向（No.465）](https://www.jmari.med.or.jp/result/working/post-3389/) | 2022-03-23 | 国内外の政策と関連団体の取り組みの整理、製造販売業者と医療現場への調査 |
| [医療現場のサイバーセキュリティ確保に向けて：専門家インタビュー調査から（No.488）](https://www.jmari.med.or.jp/result/working/post-4657/) | 2024-12-10 | 専門家, 実務家へのインタビューにもとづく、医療機関, 業界, 行政それぞれへの提言 |
| [医師会共同利用施設のサイバーセキュリティ：医師会病院と健診, 検査センター, 複合体の実態（No.501）](https://www.jmari.med.or.jp/result/working/post-5118/) | 2026-02-24 | 医師会共同利用施設に対象を絞った実態調査 |
| [医療機器高度化に伴う医療情報のサイバーセキュリティマネジメントに関する研究（RP077）](https://www.jmari.med.or.jp/result/other/post-218/) | 2021-03 | 委託研究報告書 |

### No.453：管理体制の実態（2021 年）

**事実**：病院約 5,000 施設、診療所約 5,000 施設を対象とした調査で、回収数は 2,989、回収率は 30.4% であった。
ネットワーク構成図を保有して計画的に見直している施設は 5.7%、構成図を保有していない施設は約 5 割であった。
専任の担当部門があるのは 2 割強、対策費用を計画的に準備しているのは 1 割強、従業員教育を実施していない施設は 4 分の 3 を超えた（[No.453](https://www.jmari.med.or.jp/result/working/post-233/)）。

**分析**：構成図の不在は、単に資料が足りないという話ではない。
どこが外部と接続しているかを把握していない状態では、対策の優先順位を決める前提が欠ける。
[組織の脆弱性の分類](../../threats/actors/organizational-vulnerabilities.md) が棚卸しから始まるのは、この点に対応している。

### No.488：専門家インタビューからの提言（2024 年）

**事実**：ICT, 情報セキュリティの専門家, 実務家, 学識経験者を対象に、2024 年 5 月から 10 月にかけて計 8 団体、18 人を対象とする非構造化面接法によるインタビューが行われた。
提言は「自助（医療機関）」「共助（医療界, 情報システム業界, 保険業界）」「公助（政治, 行政）」の三層に整理されている（[No.488](https://www.jmari.med.or.jp/result/working/post-4657/)）。

**事実**：医療機関に対しては、ICT 資産管理、ネットワーク構成図の作成と更新、ネットワークの出入口対策、端末と VPN 機器の脆弱性対応、ネットワーク内部の監視、被害最小化策（オフラインバックアップ、セグメンテーション、BCP、サイバー保険）が挙げられている。
あわせて、保守契約への委託事項の明記、複数ベンダが並立する場合のプライムベンダーの設置、希少な ICT 人材を地域ごとに共有する仕組みの構築が提言されている。

**事実**：国に対しては、司令塔組織の見直しと強化、脆弱性情報の確実な伝達と対策実装の支援、システム仕様書を点検する第三者機関の創設、SOC の制度化と医療機関向け地域別 SOC の構築支援、有事の相談窓口の一本化、財源の確保と国民, 患者への説明、健康, 医療データの廃棄ルールと真正性担保の政策議論が提言されている。

**分析**：この提言のうち、地域別 SOC と人材の共有は、[厚生労働科学研究の地域共通基盤の実証](#国内の公的研究)と同じ方向を向いている。
一施設で 24 時間 365 日の監視要員を確保できないという制約は共通しており、解を施設の外に置く点で一致する。
一方で、仕様書を点検する第三者機関の提案は、[医療 DX](../../technology/dx-ax/) やガイドラインの議論のなかでは、本リポジトリで扱っている範囲に見当たらない論点である。
自院の構成を把握していない状態がベンダ任せの仕様書作成に由来するという指摘は、責任分界点の設計にそのまま関わる。

### No.501：医師会共同利用施設の実態（2026 年）

**事実**：医師会病院 65 施設、健診, 検査センター, 複合体 160 施設の計 225 施設を対象とした調査で、回答は 135 施設、回収率は 60% であった。
調査対象期間にランサムウェア感染はなく、医師会病院の体制と対策は 2025 年に厚生労働省が調査した同規模病院と同等以上とされた一方、健診, 検査センターでは整備が遅れており、対策費用の準備がないと回答した施設が約 6 割弱にのぼった（[No.501](https://www.jmari.med.or.jp/result/working/post-5118/)）。

**分析**：健診, 検査センターは、病院と同じ要配慮個人情報を扱いながら、病院ほど規制と補助の対象として扱われてこなかった。
[委託と供給網の連鎖](../../threats/actors/ransomware-chain.md#委託と供給網の連鎖)で見たとおり、検査を受託する事業者の停止は複数の医療機関に同時に及ぶ。
病院単体の成熟度ではなく、検査, 健診, 決済を含めた地域単位で見ないと、実際の弱点は見えない。

---

## 業界の指針, 枠組み

| 文書 | 概要 |
|---|---|
| [OWASP Secure Medical Device Deployment Standard](https://cloudsecurityalliance.org/artifacts/owasp-secure-medical-devices-deployment-standard) | 医療機関が医療機器を安全に導入, 運用するための基準 |
| [I Am The Cavalry: Hippocratic Oath for Connected Medical Devices](https://iamthecavalry.org/) | 接続された医療機器に対する五つの原則。設計思想として広く参照される |
| [MITRE: Playbook for Threat Modeling Medical Devices](https://www.mitre.org/) | 医療機器の脅威モデリング手法 |
| [MITRE: Medical Device Cybersecurity Regional Incident Preparedness and Response Playbook](https://www.mitre.org/) | 医療機器インシデントに対する、地域連携を含む対応計画 |
| [MITRE: Rubric for Applying CVSS to Medical Devices](https://www.mitre.org/) | 医療機器の脆弱性評価に CVSS を適用する際の指針。患者への危害を評価に織り込む |
| [MDS2（HIMSS / NEMA HN 1）](https://www.himss.org/) | 医療機器のセキュリティ仕様を開示するための標準様式 |

CVSS をそのまま医療機器に適用すると、患者への危害という観点が評価から抜け落ちる。
MITRE の Rubric は、この差を埋めるために作られている。

---

## 標準

| 標準 | 対象 |
|---|---|
| [ISO 13485](https://www.iso.org/standard/59752.html) | 医療機器の品質マネジメントシステム |
| [ISO 14971](https://www.iso.org/standard/72704.html) | 医療機器のリスクマネジメント |
| [IEC 81001-5-1](https://www.iso.org/standard/76097.html) | 医療機器ソフトウェアのセキュアな開発ライフサイクル |
| [HL7 標準](http://www.hl7.org/implement/standards/index.cfm) | 医療情報交換の標準規格 |
| [DICOM 標準](https://www.dicomstandard.org/) | 医用画像の規格。Part 15 がセキュリティプロファイルを規定する |

---

## 継続的に参照する調査レポート

| 発行元 | 内容 |
|---|---|
| [HHS OCR Breach Portal](https://ocrportal.hhs.gov/ocr/breach/breach_report.jsf) | 米国で報告された医療情報侵害の一次データ。傾向分析に使える |
| [ENISA Threat Landscape: Health Sector](https://www.enisa.europa.eu/) | EU の医療分野脅威分析 |
| [IPA 情報セキュリティ白書](https://www.ipa.go.jp/publish/wp-security/index.html) | 国内の年次動向 |
| [警察庁 サイバー空間をめぐる脅威の情勢等](https://www.npa.go.jp/publications/statistics/cybersecurity/index.html) | 国内のランサムウェア被害統計（業種別の内訳を含む） |

---

<sub>[トップへ](../../../README.md)</sub>
