# 🧰 ツール

医療セキュリティの検証と運用に使えるツールをまとめる。

> [!NOTE]
> **表記ルール**：本ページでは、**事実**（一次情報で確認できる内容。出典を併記する）、**報道ベース**（報道のみで確認でき、当事者の公表資料では裏付けが取れていない内容）、**分析**（筆者の解釈）を書き分ける。
> 出典は、当事者の公表資料、行政文書、CVE、ベンダアドバイザリなどの一次情報を優先して示す。

> [!WARNING]
> ここに挙げるツールは、自組織の資産、または許可を得た対象に対してのみ使用できる。
> 稼働中の医療機器に対するスキャンは、機器の停止や誤動作を引き起こす可能性がある。
> 検証は隔離環境で行い、本番環境での実施には書面での承認と、臨床部門の立ち会いを得てほしい。

---

## DICOM, 医用画像

| ツール | 用途 |
|---|---|
| [DCMTK](https://dicom.offis.de/dcmtk) | DICOM の標準的なツールキット。`echoscu`, `findscu`, `movescu`, `storescu` による疎通確認と通信検証 |
| [pydicom](https://github.com/pydicom/pydicom) | Python による DICOM ファイルの解析, 生成。タグ検証の自動化に使える |
| [pynetdicom](https://github.com/pydicom/pynetdicom) | Python による DICOM ネットワーク通信の実装。検証用のサーバ, クライアント構築 |
| [Orthanc](https://www.orthanc-server.com/) | 軽量な PACS サーバ。検証環境の構築に使える |
| [dcm4che](https://github.com/dcm4che/dcm4che) | Java 製の DICOM ツールキット |
| [fo-dicom](https://github.com/fo-dicom/fo-dicom) | .NET の DICOM 実装 |
| [Evil-DICOM](https://github.com/rexcardan/Evil-DICOM) | C# の DICOM 操作ライブラリ |
| [GDCM](https://sourceforge.net/projects/gdcm/) | `gdcmanon` による匿名化を含む DICOM 処理ライブラリ |
| [DICOM Anonymizer](https://github.com/KitwareMedical/dicom-anonymizer) | DICOM の匿名化ツール |

---

## HL7, FHIR

| ツール | 用途 |
|---|---|
| [HAPI HL7v2](https://github.com/hapifhir/hapi-hl7v2) | Java の HL7 v2 パーサ |
| [HAPI FHIR](https://hapifhir.io/) | Java の FHIR 実装。参照サーバとしても使える |
| [python-hl7](https://github.com/johnpaulett/python-hl7) | Python の HL7 v2 パーサ |
| [nHapi](https://github.com/nHapiNET/nHapi) | .NET の HL7 v2 実装 |
| [HL7Fuse](https://github.com/dib0/HL7Fuse) | HL7 メッセージのルーティングサービス |
| [HL7 Snoop](https://github.com/dgrinberg/HL7-Snoop) | HL7 メッセージの解析, 表示 |
| [Mirth Connect / NextGen Connect](https://github.com/nextgenhealthcare/connect) | HL7 連携エンジン。検証環境の構築にも使える |
| [Inferno](https://inferno-framework.github.io/) | FHIR サーバの適合性テストツール |
| [Synthea](https://github.com/synthetichealth/synthea) | 合成患者データの生成。実データを使わずに検証環境を作れる |

> [!TIP]
> 検証には必ず合成データを使ってほしい。
> Synthea は、実在しない患者の診療履歴を FHIR, HL7, CSV 形式で生成できる。
> 医療システムの検証環境を作るとき、実データを持ち込まないための最も実用的な手段になる。

---

## ネットワーク, 資産可視化

| ツール | 用途 |
|---|---|
| [Nmap](https://nmap.org/) | ポートスキャン。DICOM 用の NSE スクリプトも存在する |
| [Zeek](https://zeek.org/) | ネットワーク通信の記録, 分析。医療機器セグメントの可視化に使える |
| [Wireshark](https://www.wireshark.org/) | DICOM, HL7 プロトコルの解析（両方ともディセクタが用意されている） |
| [Shodan](https://www.shodan.io/) | 自組織の資産の外部露出確認 |
| [Censys](https://censys.io/) | 同上 |

> [!IMPORTANT]
> 稼働中の医療機器に対する Nmap のスキャンは、機器の応答停止を引き起こした事例が報告されている。
> 医療機器セグメントの可視化には、能動的なスキャンではなく、通信の受動的な観測（Zeek などのパッシブ監視）を優先してほしい。

---

## 脆弱性管理, SBOM

| ツール | 用途 |
|---|---|
| [OSV-Scanner](https://github.com/google/osv-scanner) | 依存パッケージの脆弱性検出 |
| [Syft](https://github.com/anchore/syft) | SBOM の生成 |
| [Grype](https://github.com/anchore/grype) | SBOM や成果物に対する脆弱性検出 |
| [Trivy](https://github.com/aquasecurity/trivy) | コンテナ, ファイルシステム, IaC の脆弱性検出 |
| [Dependency-Track](https://dependencytrack.org/) | SBOM を継続的に管理し、新規脆弱性を追跡する |

医療機器メーカーにとって、SBOM の生成と継続的な追跡は規制要求への対応そのものになる。
医療機関にとっては、調達時に受け取った SBOM を Dependency-Track のような仕組みに取り込むことで、新しい脆弱性が公表されたときに自組織への影響を即座に判断できる。

---

## Web アプリケーション検証

医療系 Web アプリの検証は、一般的な Web 診断と同じツールで行える。

| ツール | 用途 |
|---|---|
| [Burp Suite](https://portswigger.net/burp) | Web アプリケーションの検証 |
| [OWASP ZAP](https://www.zaproxy.org/) | 同上（オープンソース） |
| [Caido](https://caido.io/) | Web プロキシツール |

医療系での使い方は、[患者用ポータルで狙われやすい脆弱性](../../technology/web-security/patient-portal.md)を参照してほしい。

---

## 検証環境の構築

| 対象 | 構築方法 |
|---|---|
| OpenEMR | 公式の Docker 構成を利用（[詳細](../../technology/oss-vulnerabilities/ehr-systems.md)） |
| Orthanc | `docker run jodogne/orthanc-plugins`（[詳細](../../technology/oss-vulnerabilities/imaging-pacs.md)） |
| OpenMRS | 公式の Docker 構成を利用 |
| HAPI FHIR | 公式のコンテナイメージを利用 |
| テストデータ | Synthea による合成データ、[TCIA](https://www.cancerimagingarchive.net/) の公開画像データセット |

---

<sub>[トップへ](../../../README.md)</sub>
