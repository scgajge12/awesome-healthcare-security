# 🎓 学習リソース

医療セキュリティを学ぶための講演、カンファレンス、教材をまとめる。

> [!NOTE]
> **表記ルール**：本ページでは、**事実**（一次情報で確認できる内容。出典を併記する）、**報道ベース**（報道のみで確認でき、当事者の公表資料では裏付けが取れていない内容）、**分析**（筆者の解釈）を書き分ける。
> 出典は、当事者の公表資料、行政文書、CVE、ベンダアドバイザリなどの一次情報を優先して示す。

---

## 講演

この分野の全体像をつかむには、実務者の講演を見るのが早い。
以下は繰り返し参照される講演である。

### 医療機器セキュリティの入門

| 講演 | 話者 |
|---|---|
| [Medical Device Cyber Security: The First 164 Years](https://www.youtube.com/watch?v=QKgdvmomopw) | Kevin Fu |
| [Implantable Medical Devices](https://www.youtube.com/watch?v=shTj9WVhVyU) | Kevin Fu |
| [The Scientific Method in Security Research](https://www.youtube.com/watch?v=UkA9JOUcFi4) | Jay Radcliffe |
| [Hacking Medical Devices for Fun and Insulin: Breaking the Human SCADA System](https://www.youtube.com/watch?v=avf5XF8yS60) | Jay Radcliffe |
| [Protecting Medical Devices from Cyberharm](https://www.youtube.com/watch?v=EyqwUFJKZo0) | Stephanie Domas |
| [Hacking Medical Devices](https://www.youtube.com/watch?v=KIU2mNpXsPg) | Florian Grunow |
| [Medical Security Nightmares](https://www.youtube.com/watch?v=0F_eScTUris) | Florian Grunow（ドイツ語） |
| [Medical Device Security: Please (don't) be patient!](https://www.youtube.com/watch?v=0r6SodNXGJM) | Julian Suleder |

### 医療機関の現場から

| 講演 | 話者 |
|---|---|
| [Tales of A Healthcare Hacker](https://www.youtube.com/watch?v=ij7uuY-3eXk) | Kevin Sacco |
| [Hospitals And Infosec](https://www.youtube.com/watch?v=5QDdXPWZS1c) | Jelena Milosevic |
| [Digital Disease: How Healthcare Cybersecurity Challenges...](https://www.youtube.com/watch?v=yjZ-KiZlk7Q) | Christian Dameff |
| [Medical Devices: Pwnage and Honeypots](https://www.youtube.com/watch?v=ZusL2BY6_XU) | Scott Erven, Mark Collao |
| [State of Medical Device Cyber Safety](https://www.youtube.com/watch?v=SLMafs9FMvE) | Beau Woods, Scott Erven |
| [Anatomy of a Medical Device Hack: Doctors vs Hackers in a Clinical Simulation Cage Match](https://www.youtube.com/watch?v=FnvcocyI4pI) | Joshua Corman ほか |

### 設計と運用

| 講演 | 話者 |
|---|---|
| [Standardizing Deployment Of Medical Devices](https://www.youtube.com/watch?v=ODiZc04CzgE) | Christopher Frenz |
| [Medical Device Threat Modeling with Templates](https://www.youtube.com/watch?v=_5uVtINSr_w) | Valery Berestetsky, Jonathan Schaaf |
| [Hacking Medical Devices And Healthcare Infrastructure](https://www.youtube.com/watch?v=3S6RQo-OQ24) | Anirudh Duggal |
| [Abusing IoT Medical Devices For Your Precious Health Records](https://www.youtube.com/watch?v=w7kI4M9Ym2Q) | Saurabh Harit, Nick Delewski |
| [Medical Device Ethics](https://www.youtube.com/watch?v=g3lvY5an4-E) | Stanislav Naydin, Vlad Gostomelsky |

Christian Dameff は救急医であり、セキュリティ研究者でもある。
臨床とセキュリティの両方の語彙を持つ話者の講演は、この分野で何が本当に問題なのかを理解する助けになる。

---

## プロトコルの学習

医療システムを扱うには、HL7 と DICOM の理解が前提になる。

| リソース | 内容 |
|---|---|
| [HL7 標準](http://www.hl7.org/implement/standards/index.cfm) | HL7 の公式標準文書 |
| [HL7 解説動画（YouTube プレイリスト）](https://www.youtube.com/watch?v=ZAgdYR1rmEQ&list=PLNH9Hx9ks4CediBpp9Yr9N8icTfCr0TUN) | HL7 v2 プロトコルの解説 |
| [HL7 Message Flow](https://www.youtube.com/watch?v=-suRA7cJ9fI) | HL7 メッセージの流れ |
| [DICOM 標準](https://www.dicomstandard.org/) | DICOM の公式規格文書 |
| [FHIR 公式ドキュメント](https://www.hl7.org/fhir/) | FHIR の仕様 |

HL7 v2 は、パイプ区切りのテキストという素朴な形式を持つ。
一見して読めるが、セグメントの意味と施設ごとの拡張を理解しないと、業務上の意味を取り違える。
FHIR は REST ベースの新しい規格であり、Web セキュリティの知識がそのまま適用できる。

---

## カンファレンス

| 名称 | 概要 |
|---|---|
| [Biohacking Village（DEF CON）](https://www.villageb.io/) | 実機の医療機器を対象とした Device Lab を開催する |
| [CyberMed Summit](https://www.cybermedsummit.org/) | 医師とセキュリティ研究者による臨床シミュレーション形式の演習 |
| [HIMSS Global Conference](https://www.himss.org/) | 医療 IT 全般。セキュリティのセッションを含む |
| [S4](https://s4xevents.com/) | 制御システムセキュリティ。医療機器のセッションが含まれることがある |
| [Black Hat / DEF CON](https://www.blackhat.com/) | 医療機器, 医療システムの研究発表が定期的に行われる |

---

## 実践的に学ぶ

医療セキュリティは、実際に触れないと理解が進まない。

1. **検証環境を作る**：OpenEMR や Orthanc をローカルに構築する（[ツール](tools.md)）
2. **合成データを流す**：Synthea で患者データを生成し、システムに投入する
3. **プロトコルを観察する**：Wireshark で HL7, DICOM の通信を見る
4. **脆弱性を追う**：対象製品の CVE と修正コミットを読み、何が問題だったかを理解する
5. **報告する**：発見した問題は、プロジェクトのセキュリティポリシーに従って報告する

---

## 関連ページ

- [ツール](tools.md)
- [論文, レポート](research.md)
- [ラボ, コミュニティ](../labs-communities/README.md)

---

<sub>[トップへ](../../../README.md)</sub>
