<div align="center">

# 🏥 Awesome Healthcare Security

**医療業界 × サイバーセキュリティ**の知見を、国内外の一次情報にもとづいて体系化したキュレーションリポジトリ

<br>

[![Awesome](https://awesome.re/badge-flat2.svg)](https://github.com/sindresorhus/awesome)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-blue.svg?style=flat-square)](LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/scgajge12/awesome-healthcare-security?style=flat-square)](https://github.com/scgajge12/awesome-healthcare-security/commits/main)
[![Stars](https://img.shields.io/github/stars/scgajge12/awesome-healthcare-security?style=flat-square)](https://github.com/scgajge12/awesome-healthcare-security/stargazers)

**[日本語](README.md)** | [English](README-en.md)

<br>

[**脅威**](docs/threats/) |
[**技術領域**](docs/technology/) |
[**検証と実務**](docs/practice/) |
[**ガイドラインと法規制**](docs/guidelines/) |
[**リファレンス**](docs/reference/) |
[**月報**](monthly-reports/)

</div>

---

## なぜ「医療 × セキュリティ」なのか

生命に関わるインフラは医療だけではない。
医療と製薬に固有なのは、守る対象が情報システムではなく**診療と医薬品供給の継続**である点にある。
一般の企業システムが機密性を最優先に設計されるのに対し、ここでは可用性と完全性が先に来る。
検査値が 1 桁ずれたまま参照できる状態や、製造記録が書き換わったまま出荷が続く状態は、システムが停止している状態より危険になりうる。
この優先順位の違いが、以下の六つの制約の出発点になっている。

以下では、病院などの医療機関と、製薬企業の双方を対象とする。

<table>
<tr>
<td width="50%" valign="top">

### ⏱️ 判断に猶予がない

24/365 稼働が前提で、計画停止の調整さえ難しい。
停止が長引けば、救急の受入可否、手術の延期、医薬品の出荷停止といった判断に直接つながる。
対策が正しいかどうかではなく、適用できる時間枠があるかどうかが争点になる。

</td>
<td width="50%" valign="top">

### 🚪 「閉域だから安全」という前提

医療情報システムも製造ラインの制御系も、外部から切り離された閉域網を前提に設計されてきた。
その前提が、境界機器のパッチ適用を後回しにする理由として働く。
実際の侵入は、その境界機器から始まる。

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 🕰️ 古い資産と、把握しきれない構造

医療機器のライフサイクルは 10 年を超え、サポート切れ OS が現役で稼働する。
規制下にある機器や、バリデーション済みの製造設備は、承認を経ずに構成を変えられない。
電子カルテ、部門システム、医療機器、製造ラインの制御系、事務系が同じ網に同居し、管理主体もベンダも分かれる。
何がどこにつながっているかを描けない状態では、影響範囲の見積もりも隔離もできない。

</td>
<td width="50%" valign="top">

### 🔗 攻撃対象領域が自組織で完結しない

給食、検査、清掃、保守などの委託事業者や、原薬、受託製造の取引先との接続が侵入経路になる。
自組織の内側だけを対象にした設計では、外側から入られる経路を塞げない。

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 💊 無効化できないデータが、まとまって置かれている

診療情報は、カード番号と違って再発行できない。
病名や治療歴は生涯変わらず、氏名、住所、保険資格までが同じ場所に揃う。
製薬では、これに治験データと承認前の研究情報が重なり、盗まれた時点で価値が戻らない。
どちらも、暗号化と暴露を組み合わせた二重恐喝が効きやすい。

</td>
<td width="50%" valign="top">

### 💰 支払いに傾く条件が揃っている

攻撃者が見ているのはデータの価値ではなく、回収できる確率である。
診療や出荷が止まる緊急度が高く、復旧に時間がかかり、患者の安全が人質になる構造では、支払いの判断に傾きやすい。
この期待値の高さが、医療と製薬が狙われ続ける理由になっている。

</td>
</tr>
</table>

この六つは独立していない。
閉域網への信頼が資産管理と分離の遅れを許し、その状態で委託先から侵入されると、止められないはずのシステムが止まる。
狙う側の動機は、金銭、諜報、政治的主張と分かれるが、通る入り口は重なる。
そのため防御の設計は、アクターの分類ではなく入り口の数で決まる（[脅威アクターとリスク](docs/threats/actors/actors-and-risks.md)）。
実際の侵入経路と被害の広がりは、[インシデント事例集](docs/threats/incidents/)にまとめている。

### 前提が崩れる速度：DX と AX

オンライン資格確認や電子処方箋のように、外部ネットワークとの接続を前提とする仕組みの導入が進んでいる。
一方で、接続点の棚卸し、権限設計、通信の監視、事故時の運用は、後から追いかける形になりやすい。
閉域網を前提とした設計思想のまま接続点だけが増えると、閉域への信頼と構造の不透明さが同時に悪化する。

AI の導入（AX）は、この差をさらに広げる。
生成 AI は上の六つを新しく生むわけではないが、いずれの時間軸も詰める方向に働く。

1. **悪用までの猶予が縮む**：脆弱性の解析や標的に合わせたメールの生成が自動化され、公開から悪用までの期間が短くなる。
   パッチ適用に月単位を要する医療は、この短縮の影響を受けやすい側にいる。
2. **診療と開発のフローに LLM が入る**：カルテ本文、患者が入力した問診票、外部から届く紹介状の OCR テキスト、治験文書や安全性情報が、そのまま LLM の入力になる。
   これらは攻撃者が内容を書き込みうる外部入力であり、間接プロンプトインジェクションの経路になる。
3. **エージェントが EHR に接続する**：認可の不備が、1 件の漏えいではなく患者横断の参照に直結する。
   従来の IDOR が、自然言語の指示ひとつで大量取得に変わる。
4. **更新できない問題が繰り返される**：AI を組み込んだプログラム医療機器では、モデルの更新そのものが承認プロセスの対象になる。
   メーカー承認なしに更新できないという制約が、更新頻度の高いモデルで再演される。

いずれも、現場が新しい技術を取り入れる速度と、規制と運用が追いつく速度の差から生じている。
国の基盤ごとの接続点と、医療に AI を組み込むときの脅威は、[医療 DX と AX](docs/technology/dx-ax/) にまとめている。

### フロンティア AI × 重要インフラ（医療）

医療は、各国で重要インフラとして位置づけられている（[ガイドラインと法規制](docs/guidelines/)）。
フロンティアモデルの能力向上は攻撃側と防御側の双方に効くが、届く順序が違う。
攻撃側は新しい能力を公開された日から使えるのに対し、医療機関や製薬企業が同じ能力を運用に組み込むには、規制、調達、検証の工程を通る必要がある。
この時間差は、更新の遅い分野ほど大きくなる。

- **防御計画を、モデル側の安全対策に依存させない**：悪用への制限は提供者ごとに異なり、時期によっても変わる。
  守りの前提として数えない。
- **人手が足りない作業から効果が出る**：資産の棚卸し、ログの要約、アドバイザリの影響判定など、人員の制約で頻度を落としてきた作業に向く。
- **出力が診療判断に入るなら、完全性の問題として扱う**：入力データの改ざんやモデルへの毒入れは、情報漏えいではなく患者安全に関わる事象になる。

2026 年 5 月 18 日には、この時間差を前提とした要請が政府から出ている。
内閣官房国家サイバー統括室ほか 8 機関の連名による重要インフラ事業者等への注意喚起と、対策パッケージ Project YATA-Shield である。
求められているのは、脆弱性の発見から悪用までの時間が短くなることを前提とした資産管理と、優先順位付けの体制である（[AX：医療における AI のセキュリティ](docs/technology/dx-ax/ai-security.md)）。

本リポジトリは、医療機関と製薬企業のセキュリティ担当者、医療機器メーカー、セキュリティ研究者、規制対応担当者が、それぞれの立場で必要な情報にたどり着けることを目指す。

<p align="center">
  <img src="assets/attack-surface-map.svg" alt="医療機関の攻撃対象領域。外部の侵入口は VPN やリモートアクセス、委託事業者との接続、メール、患者向け公開サービス、メーカーの保守回線。院内での水平展開を経て、電子カルテ、部門システム、医療機器、バックアップに到達し、診療の停止に至る。" width="100%">
</p>

---

## 📚 コンテンツ

`docs/` は五つの群に分かれている。
脅威を知り、守る対象を把握し、検証し、規制を確認し、参照材を引く、という順に並べた。

### 🎯 [脅威](docs/threats/)

<table>
<tr>
<td width="50%" valign="top">

#### 🚨 [インシデント事例集](docs/threats/incidents/)

国内外の医療機関に対する攻撃事例。侵入経路、侵害範囲、診療への影響、再発防止策まで追跡する。

- [国内の事例](docs/threats/incidents/japan.md)
- [海外の事例](docs/threats/incidents/global.md)

</td>
<td width="50%" valign="top">

#### 🎯 [脅威アクターと TTPs](docs/threats/actors/)

医療を狙うアクターと動機を整理し、ランサムウェアグループの TTPs を ATT&CK にマッピングして防御策と対応づける。

- [脅威アクターとリスク](docs/threats/actors/actors-and-risks.md)
- [グループ別 TTPs](docs/threats/actors/ransomware-groups.md)
- [防御プレイブック](docs/threats/actors/defense-playbook.md)
- [組織の脆弱性の分類](docs/threats/actors/organizational-vulnerabilities.md)

</td>
</tr>
</table>

### 🧩 [技術領域](docs/technology/)

<table>
<tr>
<td width="50%" valign="top">

#### 🩺 [医療機器のセキュリティ](docs/technology/medical-devices/)

IoMT、PACS/DICOM 固有のリスクと、安全に検証するための手法。

- [IoMT（医療 IoT 機器）のリスク](docs/technology/medical-devices/iomt.md)
- [PACS / DICOM のセキュリティ](docs/technology/medical-devices/pacs-dicom.md)
- [医療機器の検証手法](docs/technology/medical-devices/testing-methodology.md)

</td>
<td width="50%" valign="top">

#### 🧬 [OSS 医療情報システムの脆弱性](docs/technology/oss-vulnerabilities/)

OSS 電子カルテ、医用画像 OSS の脆弱性事例と CVE。研究対象としての入口。

- [OSS 電子カルテ、HIS](docs/technology/oss-vulnerabilities/ehr-systems.md)
- [医用画像 OSS（PACS/DICOM 実装）](docs/technology/oss-vulnerabilities/imaging-pacs.md)

</td>
</tr>
<tr>
<td width="50%" valign="top">

#### 🌐 [医療系 Web アプリのセキュリティ](docs/technology/web-security/)

患者ポータル、オンライン診療で狙われやすい脆弱性。

- [患者用ポータルの脆弱性](docs/technology/web-security/patient-portal.md)

</td>
<td width="50%" valign="top">

#### ☁️ [クラウド事業者と医療](docs/technology/cloud/)

AWS、Google Cloud、Azure、さくらインターネットの責任分界と、クラウド上の医療システムが侵害される経路。

</td>
</tr>
<tr>
<td width="50%" valign="top">

#### 🔄 [医療 DX と AX](docs/technology/dx-ax/)

国の基盤で増える接続点と、医療に AI を組み込むときの脅威。前提が崩れる速度を扱う。

- [医療 DX：国の基盤と接続点](docs/technology/dx-ax/medical-dx.md)
- [AX：医療における AI のセキュリティ](docs/technology/dx-ax/ai-security.md)

</td>
<td width="50%" valign="top">
</td>
</tr>
</table>

### 🛡️ [検証と実務](docs/practice/)

<table>
<tr>
<td width="50%" valign="top">

#### 🛡️ [診断とペネトレーションテスト](docs/practice/pentest/)

医療機関と製薬企業に対する検証を、人、外部境界、Web、クラウド、内部、医療機器、製造 OT の領域に分けて整理する。

</td>
<td width="50%" valign="top">

#### 🎯 [Bug Bounty × 医療、ヘルスケア](docs/practice/bug-bounty/)

医療分野でのバグバウンティと脆弱性開示。触れてよい対象の線引き、報告経路、受け入れ側の始め方。

</td>
</tr>
</table>

### ⚖️ [ガイドラインと法規制](docs/guidelines/)

国内の 3省2ガイドラインから、HIPAA、FDA、EU MDR / NIS2 まで。

- [国内のガイドライン、法規制](docs/guidelines/japan.md)
- [海外のガイドライン、法規制](docs/guidelines/global.md)

### 📚 [リファレンス](docs/reference/)

<table>
<tr>
<td width="50%" valign="top">

#### 💊 [製薬企業のセキュリティ](docs/reference/pharma/)

治験データと知的財産の窃取、GMP 下の製造設備、原薬と受託製造の供給網。

- [治験と研究データ](docs/reference/pharma/clinical-trials.md)
- [製造設備と OT](docs/reference/pharma/manufacturing-ot.md)
- [原薬、受託製造、流通](docs/reference/pharma/supply-chain.md)

</td>
<td width="50%" valign="top">

#### 🔬 [ラボ、コミュニティ](docs/reference/labs-communities/)

医療セキュリティの研究室、ISAC、国内外のコミュニティ。

- [Biohacking Village（DEF CON）](docs/reference/labs-communities/biohacking-village.md)

</td>
</tr>
<tr>
<td width="50%" valign="top">

#### 🧰 [ツールと学習リソース](docs/reference/resources/)

- [ツール](docs/reference/resources/tools.md)
- [論文、レポート](docs/reference/resources/research.md)
- [学習リソース](docs/reference/resources/learning.md)
- [用語集](docs/reference/GLOSSARY.md)

</td>
<td width="50%" valign="top">
</td>
</tr>
</table>

### 📅 [月報](monthly-reports/)

医療分野の動向を月単位で記録する。インシデント、脆弱性、規制の動き、脅威動向。

- [月報一覧](monthly-reports/README.md)

---

## 🗂️ リポジトリの構成

```
awesome-healthcare-security/
├── docs/
│   ├── threats/                     脅威
│   │   ├── incidents/               インシデント事例（国内、海外）
│   │   └── actors/                  脅威アクターと TTPs、防御プレイブック
│   ├── technology/                  技術領域
│   │   ├── medical-devices/         医療機器（IoMT、PACS）のセキュリティ
│   │   ├── oss-vulnerabilities/     OSS 医療情報システムの脆弱性
│   │   ├── web-security/            医療系 Web アプリケーションのセキュリティ
│   │   ├── cloud/                   クラウド事業者と医療（AWS、Google Cloud、Azure、さくら）
│   │   └── dx-ax/                   医療 DX と AX（国の基盤、医療 AI のセキュリティ）
│   ├── practice/                    検証と実務
│   │   ├── pentest/                 セキュリティ診断とペネトレーションテスト
│   │   └── bug-bounty/              バグバウンティと脆弱性開示（医療分野）
│   ├── guidelines/                  ガイドラインと法規制
│   └── reference/                   リファレンス
│       ├── pharma/                  製薬企業のセキュリティ（治験、製造 OT、供給網）
│       ├── labs-communities/        ラボ、コミュニティ
│       ├── resources/               ツール、論文、学習リソース
│       ├── _templates/              事例追加のテンプレート
│       └── GLOSSARY.md              用語集
├── monthly-reports/                 月報（YYYY/YYYY-MM.md）
├── skills/                          文書レビュー用のスキル
├── scripts/                         リンク切れ確認のスクリプト
├── .githooks/                       コミット前に走らせるフック
└── assets/                          図（SVG）
```

## ✍️ 記述の方針

本リポジトリは、セキュリティ実務者が意思決定に使えることを前提に、次の四つを徹底する。

| 原則                           | 内容                                                                                  |
| ------------------------------ | ------------------------------------------------------------------------------------- |
| **事実と推測を分ける**         | 公表された一次情報にもとづく記述と、筆者の分析や推測を区別して表記する                |
| **一次情報にリンクする**       | 報道の二次引用ではなく、当事者の公表資料、行政文書、CVE、ベンダアドバイザリを優先する |
| **断定できないことは書かない** | 攻撃グループの帰属や被害額など、確度の低い情報は「未確認」と明記する                  |
| **防御に資する形で書く**       | 攻撃手法は、必ず検知、緩和策とセットで記述する                                        |

---

## ⚠️ 免責事項

> [!WARNING]
> **稼働中の医療機器や医療情報システムに対する無断の検証は、患者の生命を危険にさらしうる。**
> 検証は書面での許可を得たうえで、隔離環境または承認されたテスト環境で実施してほしい。

- 本リポジトリは、教育と防御を目的とした情報提供である。記載された技術情報を、権限のないシステムに対して使うわけにはいかない。
- 記載内容は執筆時点のものであり、正確性と完全性を保証しない。規制やガイドラインへの対応にあたっては、原文および所管官庁の最新情報を確認してほしい。
- 本リポジトリの内容は著者個人の見解であり、所属組織の見解を代表しない。

---

## 📄 ライセンス

本リポジトリは [CC BY 4.0](LICENSE)（クリエイティブ・コモンズ 表示 4.0 国際）で公開している。

---

<div align="center">

## 👤 Author

**Yuta Morioka / morioka12**

Security Engineer・Ethical Hacker

[![GitHub](https://img.shields.io/badge/GitHub-scgajge12-181717?style=flat-square&logo=github)](https://github.com/scgajge12)
[![X](https://img.shields.io/badge/X-@scgajge12-000000?style=flat-square&logo=x)](https://x.com/scgajge12)
[![Web](https://img.shields.io/badge/Web-scgajge12.github.io-0A66C2?style=flat-square&logo=googlechrome&logoColor=white)](https://scgajge12.github.io/)

<br>

<sub>© 2026 Yuta Morioka (morioka12) — Licensed under <a href="LICENSE">CC BY 4.0</a></sub>

</div>
