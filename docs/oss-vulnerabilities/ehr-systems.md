# OSS 電子カルテ、病院情報システムの脆弱性

主要な OSS 電子カルテと病院情報システムについて、報告されてきた脆弱性の傾向をまとめる。

> [!NOTE]
> **表記ルール**：本ページでは、**事実**（一次情報で確認できる内容。出典を併記する）、**報道ベース**（報道のみで確認でき、当事者の公表資料では裏付けが取れていない内容）、**分析**（筆者の解釈）を書き分ける。
> 出典は、当事者の公表資料、行政文書、CVE、ベンダアドバイザリなどの一次情報を優先して示す。
>
> 個別の CVE 番号は、誤記を避けるため列挙していない。
> 製品ごとに NVD の検索リンクを用意しているので、最新の一覧は一次情報で確認してほしい。

---

## 主要な OSS 医療情報システム

| 製品 | 技術スタック | 用途 | 一次情報 |
|---|---|---|---|
| **OpenEMR** | PHP / MySQL | 電子カルテ＋診療所管理。OSS 医療システムで最も広く使われている | [公式](https://www.open-emr.org/) | [GitHub](https://github.com/openemr/openemr) | [NVD](https://nvd.nist.gov/vuln/search/results?query=openemr) |
| **OpenMRS** | Java / Spring | 新興国の医療現場で広く導入されているモジュール型 EMR プラットフォーム | [公式](https://openmrs.org/) | [GitHub](https://github.com/openmrs) | [NVD](https://nvd.nist.gov/vuln/search/results?query=openmrs) |
| **Bahmni** | OpenMRS ベース | 病院情報システム（EMR + LIS + 会計 + 画像連携） | [公式](https://www.bahmni.org/) | [GitHub](https://github.com/Bahmni) |
| **GNU Health** | Python / Tryton | 病院情報システム＋公衆衛生。国際機関でも採用実績あり | [公式](https://www.gnuhealth.org/) |
| **LibreHealth EHR** | PHP | OpenEMR からのフォーク | [公式](https://librehealth.io/) | [GitHub](https://github.com/LibreHealthIO) |
| **OpenClinic GA** | Java | 病院情報システム。過去に多数の脆弱性が報告されている | [SourceForge](https://sourceforge.net/projects/open-clinic/) | [NVD](https://nvd.nist.gov/vuln/search/results?query=openclinic) |
| **HospitalRun** | JavaScript / Node | オフライン優先設計の病院システム | [公式](https://hospitalrun.io/) | [GitHub](https://github.com/HospitalRun) |
| **GNUmed** | Python | 電子カルテクライアント | [公式](https://www.gnumed.de/) |
| **OpenHIM / OpenHIE** | Node.js | 医療情報連携基盤（インターオペラビリティレイヤ） | [公式](https://openhim.org/) |
| **HAPI FHIR** | Java | FHIR サーバ／クライアントの参照実装。多数の医療 API の基盤 | [公式](https://hapifhir.io/) | [GitHub](https://github.com/hapifhir/hapi-fhir) |
| **Mirth Connect / NextGen Connect** | Java | HL7 連携エンジン。医療機関の統合基盤として広く使われる | [GitHub](https://github.com/nextgenhealthcare/connect) | [NVD](https://nvd.nist.gov/vuln/search/results?query=mirth+connect) |

---

## 製品別の傾向

### OpenEMR

**事実**

- PHP 製の歴史ある大規模コードベースで、世界で最も広く使われている OSS 電子カルテのひとつ。
- 複数のセキュリティ研究チームによる監査が行われており、SQL インジェクション、認証バイパス、任意ファイルアップロード、リモートコード実行に至る脆弱性の連鎖が繰り返し報告されてきた。
- 過去には、認証前の SQL インジェクションから管理者権限を奪取し、ファイルアップロード機能と組み合わせて RCE に至る一連の攻撃経路が公開されている。
- プロジェクトはセキュリティ報告の受付とパッチ提供を継続しており、脆弱性の修正履歴が GitHub 上で追跡できる。

過去に公開された攻撃経路は、単独の脆弱性ではなく連鎖として構成されている。

```mermaid
flowchart LR
    A["認証前の SQL インジェクション<br>患者検索、レポート生成"] --> B["管理者権限の取得"]
    B --> C["ファイルアップロード機能の悪用<br>拡張子検証の不備"]
    C --> D["任意コード実行"]
    D --> E["全患者の診療録と<br>サーバ自体の掌握"]
```

**着目すべき箇所（分析）**

| 領域 | 理由 |
|---|---|
| 患者検索、レポート生成 | 動的 SQL が集中しており、歴史的に SQLi の温床 |
| ポータル（患者向け画面） | 患者ロールと職員ロールの境界。IDOR が発生しやすい |
| ドキュメント管理 | アップロード、ダウンロード処理。パストラバーサルと拡張子検証の不備 |
| API（FHIR / REST） | 後付けで実装されており、画面側の権限チェックが反映されていない場合がある |
| セットアップ、インストーラ | 導入後に削除されないと、再インストールによる乗っ取りが可能になる |

### Mirth Connect（NextGen Connect）

**事実**

- HL7 メッセージのルーティングを担う統合エンジンであり、多くの医療機関でシステム間連携の中心に置かれている。
- 認証前のリモートコード実行に至る深刻な脆弱性が報告され、CISA の Known Exploited Vulnerabilities カタログに掲載された実績がある（実際の攻撃での悪用が確認された）。

**なぜ重大か（分析）**

- 連携エンジンは、その役割上、あらゆる部門システムに到達できる位置にある。ここが陥落すると、電子カルテ、検査、画像、会計のすべてに影響が及ぶ。
- 「内部システムだから」とインターネットに露出したまま放置されているケースが実際に存在する。

### OpenClinic GA

**事実**

- 認証バイパス、SQL インジェクション、パストラバーサル、任意ファイルアップロードなど、多数の CVE が公開されている。
- 公開されている PoC も多く、医療システムの脆弱性を学ぶ教材として使える。

---

## 検証環境の作り方

ほとんどの OSS 医療システムは Docker で構築できる。

```bash
# 例: OpenEMR の検証環境（公式の Docker 構成を利用）
git clone https://github.com/openemr/openemr.git
cd openemr/docker/development-easy
docker compose up -d
# ブラウザで http://localhost:8300 にアクセス
```

> [!WARNING]
> 検証環境はローカルまたは隔離ネットワークに構築し、インターネットに露出させないでほしい。
> 医療システムの初期構成は、外部公開を想定していない。

**検証時のチェックリスト**

- [ ] 実在の患者データを絶対に投入しない（ダミーデータのみ使用する）
- [ ] 検証環境をインターネットから到達不能にする
- [ ] 発見した脆弱性は、プロジェクトのセキュリティポリシーに従って報告する（[Coordinated Vulnerability Disclosure](https://www.first.org/global/sigs/vulnerability-coordination/multiparty/guidelines-v1.1)）
- [ ] 公開前に、修正版のリリースまで十分な猶予期間を設ける

---

## 関連ページ

- [医用画像 OSS（PACS/DICOM 実装）の脆弱性](imaging-pacs.md)
- [患者用ポータルで狙われやすい脆弱性](../web-security/patient-portal.md)
- [ツール](../resources/tools.md)

---

<sub>[← OSS 医療情報システムの脆弱性](README.md) | [トップへ](../../README.md)</sub>
