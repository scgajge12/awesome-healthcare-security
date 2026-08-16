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
| [On the (in)security of the Latest Generation Implantable Cardiac Defibrillators and How to Secure Them](https://www.esat.kuleuven.be/cosic/publications/article-2678.pdf) | 新しい世代の植込み型デバイスに対する解析と対策 |
| [Hacking Medical Devices for Fun and Insulin: Breaking the Human SCADA System](https://media.blackhat.com/bh-us-11/Radcliffe/BH_US_11_Radcliffe_Hacking_Medical_Devices_WP.pdf) | インスリンポンプに対する攻撃を示した Black Hat の研究 |
| [Security and Privacy Qualities of Medical Devices: An Analysis of FDA Postmarket Surveillance](https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0040200&type=printable) | FDA の市販後監視データから、医療機器のセキュリティ, プライバシー問題を分析した論文 |
| [ANATOMY OF AN ATTACK: MEDJACK](https://securityledger.com/wp-content/uploads/2015/06/AOA_MEDJACK_LAYOUT_6-0_6-3-2015-1.pdf) | 医療機器を足場として院内に潜伏する攻撃手法の報告 |
| [An Architecture for Analysis](https://www.cs.ucsb.edu/~jmcmahan/research/top_picks_18.pdf) | ペースメーカーを例に、組込み機器のセキュリティ設計を論じた研究 |

---

## インシデントの一次資料

実際に起きたことを、当事者の視点で記録した文書である。
二次的な解説より、これらを直接読むほうが得るものが多い。

| 文書 | 概要 |
|---|---|
| [HSE Conti Cyber Attack Independent Post Incident Review](https://www.hse.ie/eng/services/publications/conti-cyber-attack-on-the-hse-full-report.pdf) | アイルランド保健サービスへの攻撃に関する詳細な事後レビュー。医療機関のインシデント対応を学ぶうえで最も充実した公開文書 |
| [NAO: Investigation - WannaCry cyber attack and the NHS](https://www.nao.org.uk/reports/investigation-wannacry-cyber-attack-and-the-nhs/) | 英国国家監査院による WannaCry の影響調査 |
| つるぎ町立半田病院 コンピュータウイルス感染事案 調査報告書 | 国内の医療機関が技術的経緯を詳細に公開した事例（[公式サイト](https://www.handa-hospital.jp/)） |
| 大阪急性期, 総合医療センター 情報セキュリティインシデント調査委員会報告書 | 委託先経由の侵入を分析した国内の事例（[公式サイト](https://www.gh.opho.jp/)） |

---

## 業界の指針, 枠組み

| 文書 | 概要 |
|---|---|
| [OWASP Secure Medical Device Deployment Standard](https://owasp.org/www-project-secure-medical-device-deployment-standard/) | 医療機関が医療機器を安全に導入, 運用するための基準 |
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
| [IPA 情報セキュリティ白書](https://www.ipa.go.jp/security/publications/hakusyo/index.html) | 国内の年次動向 |
| [警察庁 サイバー空間をめぐる脅威の情勢等](https://www.npa.go.jp/publications/statistics/cybersecurity/index.html) | 国内のランサムウェア被害統計（業種別の内訳を含む） |

---

<sub>[トップへ](../../../README.md)</sub>
