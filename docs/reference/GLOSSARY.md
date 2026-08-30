# 📖 用語集

医療 IT とセキュリティが交わる領域では、双方の専門用語が混在する。
医療側の用語をセキュリティ担当者が知らず、セキュリティ側の用語を医療従事者が知らないことが、対策の議論を止める原因になりやすい。

## 用語が指す場所

医療情報システムの用語は、診療の流れに沿って並べると位置関係が分かる。
下の図の各要素が、以下の節で説明する語に対応する。

```mermaid
flowchart LR
    P["患者"] --> REC["受付、オンライン資格確認"]
    REC --> HIS["HIS（病院情報システム）"]

    subgraph HIS2["HIS の内側"]
        EMR["EMR（電子カルテ）"]
        ORD["オーダリング"]
    end

    HIS --- HIS2
    ORD -->|"検査の指示"| LIS["LIS（検査）"]
    ORD -->|"撮影の指示"| RIS["RIS（放射線）"]
    RIS --> MOD["モダリティ<br>CT、MRI、超音波"]
    MOD -->|"DICOM"| PACS["PACS（画像の保管）"]
    LIS -->|"HL7 v2"| EMR
    PACS -->|"DICOM"| EMR
    HIS -->|"レセプト"| INS["保険者、審査支払機関"]
    EMR -->|"FHIR"| EXT["外部連携<br>他院、患者アプリ、EHR"]
```

**分析**：セキュリティの検討でこの図が効くのは、データが施設の外へ出る点が二箇所しかないことを示せるためである。
レセプトの請求と、外部連携である。
残りは院内で閉じており、そこでの防御は経路の分離と参照の記録に寄る。

---

## 医療情報システム

**EHR（Electronic Health Record）**：電子健康記録。複数の医療機関にまたがって共有されることを前提とした患者の健康情報。

**EMR（Electronic Medical Record）**：電子診療録。単一の医療機関内で管理される診療記録。日本では「電子カルテ」がこれにあたる。

**HIS（Hospital Information System）**：病院情報システム。電子カルテ、オーダリング、医事会計などを含む病院全体の情報基盤。

**オーダリングシステム**：医師が検査、処方、処置を指示（オーダ）し、各部門に伝達する仕組み。

**RIS（Radiology Information System）**：放射線科情報システム。検査の予約、実施、報告を管理する。

**PACS（Picture Archiving and Communication System）**：医用画像管理システム。画像の保存、検索、配信を担う。

**LIS（Laboratory Information System）**：臨床検査システム。検体検査の依頼から結果報告までを管理する。

**レセプト**：診療報酬明細書。医療機関が保険者に診療費を請求するための書類。

**オンライン資格確認**：マイナンバーカードや健康保険証で、患者の保険資格をオンラインで確認する仕組み。

---

## 相互運用性の規格

**HL7 v2**：医療情報交換の規格。パイプ（`|`）区切りのテキスト形式で、国内外の部門システム連携で広く使われている。認証や暗号化は規格自体に含まれない。

**HL7 FHIR（Fast Healthcare Interoperability Resources）**：REST と JSON をベースにした新しい医療情報交換規格。Web の技術とセキュリティ手法がそのまま適用できる。

**DICOM（Digital Imaging and Communications in Medicine）**：医用画像のファイル形式と通信プロトコルを規定する規格。

**AE Title（Application Entity Title）**：DICOM 通信で通信相手を識別する文字列。認証情報ではない。

**C-STORE / C-FIND / C-MOVE / C-ECHO**：DICOM の基本的な通信サービス。それぞれ画像送信、検索、取得、疎通確認にあたる。

**DICOMweb**：DICOM を HTTP 上で扱うための API 仕様。QIDO-RS（検索）、WADO-RS（取得）、STOW-RS（送信）からなる。

**MLLP（Minimal Lower Layer Protocol）**：HL7 v2 メッセージを TCP 上で送るためのフレーミング規約。メッセージの前後に区切りのバイトを付けるだけの仕様で、認証と暗号化を含まない。

**ADT / ORM / ORU**：HL7 v2 の代表的なメッセージ種別。それぞれ患者の入退院と属性、検査や処置のオーダ、検査結果の報告にあたる。

**SMART on FHIR**：FHIR API に OAuth 2.0 を組み合わせ、アプリの起動時に利用者と対象患者の文脈を渡す仕様。FHIR 自体は認証と認可を定義しないため、この層が実質的な境界になる。

**SS-MIX2**：国内で使われる、医療情報の標準化ストレージ仕様。HL7 v2 メッセージをファイルとして蓄積する。

**MML（Medical Markup Language）**：国内で使われてきた医療情報交換の記述形式。地域医療情報連携ネットワークの初期の実装で用いられた。

**IHE（Integrating the Healthcare Enterprise）**：既存規格の組み合わせ方を定めた、医療情報連携の実装ガイド。

---

## 医療機器

**IoMT（Internet of Medical Things）**：ネットワークに接続された医療機器の総称。

**モダリティ**：CT、MRI、超音波、X 線装置など、画像を生成する装置の総称。

**臨床工学技士**：医療機器の保守管理と操作を担う国家資格職。医療機関で医療機器の実態を最もよく把握している。

**MDS2（Manufacturer Disclosure Statement for Medical Device Security）**：医療機器のセキュリティ仕様をメーカーが開示するための標準様式。調達時に提出を求める。

**市販後（Postmarket）対応**：製品出荷後の脆弱性監視、報告、アップデート提供。医療機器規制で明示的に求められる。

**Legacy Device**：メーカーのサポートが終了しているか、セキュリティ更新を提供できない医療機器。IMDRF が定義と対応方針を示している。

---

## セキュリティ

**要配慮個人情報**：病歴、健康診断の結果、遺伝情報など、取扱いに特に配慮を要する個人情報。取得には原則として本人同意が必要である。

**PHI / ePHI（Protected Health Information）**：米国 HIPAA における保護対象保健情報。`e` は電子的に扱われるものを指す。

**BAA（Business Associate Agreement）**：HIPAA において、医療機関から業務を受託する事業者と結ぶ契約。

**Break-glass（緊急時アクセス）**：緊急時に、通常の権限を超えて患者情報へアクセスできるようにする仕組み。医療では正当な要件であり、事後の監査によって濫用を抑止する。

**ダウンタイム手順（Downtime Procedures）**：システムが利用できないときに、紙などで診療を継続するための手順。医療機関の事業継続の要になる。

**BCP（Business Continuity Plan）**：事業継続計画。業務が中断したときに、何をどの順で復旧し、その間どう業務を続けるかを定めた計画。医療では、自然災害を想定したものとサイバー攻撃を想定したものが別に整備されている。

**BIA（Business Impact Analysis）**：事業影響度分析。業務が停止した場合の影響を業務ごとに評価し、復旧の目標と優先順位を決める作業。BCP の前段に置く。

**RTO（Recovery Time Objective）**：目標復旧時間。業務の再開までに許容できる時間。

**RPO（Recovery Point Objective）**：目標復旧時点。復旧したときにどの時点のデータまで戻せるかの目標。バックアップの取得間隔がその上限になる。

**縮退運用**：機能の一部を止めた状態で業務を続けること。医療では、電子カルテを停止して紙運用に切り替える形が代表になる。

**責任共有モデル（Shared Responsibility Model）**：クラウド事業者と利用者の責任範囲を層で分ける考え方。セキュリティの責任分界と、可用性や復旧の責任分界は、同じ線では分かれない。

**脅威モデリング（Threat Modeling）**：対象の設計を見て、攻撃者が何をしうるかを数え上げ、対策を決める作業。実装を測る脆弱性診断と違い、まだ作られていないものについて答えられる（[医療の脅威モデリング](../practice/threat-modeling.md)）。

**信頼境界（Trust Boundary）**：統制の主体が変わる線。委託事業者との接続点、院内 LAN と医療機器ゾーンの境界、クラウド事業者との責任分界がこれにあたる。脅威は、この線をまたぐ流れに集中して現れる。

**STRIDE**：脅威をなりすまし、改ざん、否認、情報漏えい、サービス妨害、権限昇格の六種類に分けて数え上げる手法。情報セキュリティの 7 要素と近い対応を持つ。

**攻撃ツリー（Attack Tree）**：攻撃者の目標を頂点に置き、達成の手段を分解して枝に並べた図。到達経路の把握と、枝が合流する点の発見に向く。

**攻撃面（攻撃対象領域、Attack Surface）**：外部から到達できる資産と、そこが受け取る入力の総体。継続的に発見して評価する取り組みを ASM（Attack Surface Management）と呼ぶ（[外部から見た自組織の攻撃面](../practice/attack-surface.md)）。

**セグメンテーション（ネットワークの分離）**：ネットワークを性質の揃った区画（ゾーン）に分け、区画をまたぐ通信を限定すること。侵入そのものは防がず、侵入後に到達できる範囲を狭める。

**代償措置（Compensating Control）**：本来の対策を適用できないときに、別の手立てで同等のリスク低減を図る措置。医療では、パッチを当てられない医療機器に対して、経路の遮断、機能の停止、監視の追加を置く形が代表になる。

**侵入前提テスト（Assumed Breach）**：外部からの侵入に成功した状態を起点として、そこから何にどこまで到達できるかを測る検証の形式。境界の突破に時間を使わずに、内部の広がりを評価できる。

**TLPT（Threat-Led Penetration Testing）**：脅威ベースのペネトレーションテスト。対象組織を狙う脅威の分析から攻撃シナリオを起こし、本番環境に対して防御側に予告せずに実施して、検知と対応の能力を測る枠組み。金融分野では当局が制度として整備している（[レッドチームと TLPT を医療機関に当てはめる](../practice/pentest/red-team-tlpt.md)）。

**レッドチームオペレータ（Red Team Operator）**：レッドチーム演習で攻撃側の実作業を担う要員。指令基盤の構築、初期アクセス、権限昇格、目標への到達に加えて、実施した操作の記録と、テスト後の撤収までを担う。本リポジトリでは `RTO` を目標復旧時間の意味で使うため、この語を略さない。

**管理チーム（Control Team）**：TLPT で、範囲とシナリオを決め、実施を管理し、中止を判断する少人数の集まり。TIBER-EU では 2025 年 1 月版で White Team から改称された。評価される防御側（ブルーチーム）には実施を知らせない一方、業務が止まる事態を避けるために、この集まりだけが全体を把握する。

**LOTL（Living off the Land）**：攻撃者が、標的の環境に元からある正規の管理ツールを使って活動する手口。専用のマルウェアを持ち込まないため、ファイル名やハッシュ値による検知が働きにくい。

**Active Directory（AD）**：Windows 環境で、利用者、端末、権限を一元的に管理する Microsoft のディレクトリサービス。医療機関では、電子カルテ、部門システム、バックアップ、仮想化基盤の認証がここに集まる（[Active Directory の攻撃面と、段階的な手当](../technology/windows/active-directory.md)）。

**LSASS（Local Security Authority Subsystem Service）**：Windows で利用者の認証を担うプロセス。認証に使う秘密を保持するため、資格情報の窃取の標的になる。

**Credential Guard**：仮想化ベースのセキュリティで、NTLM のハッシュ、Kerberos の TGT、アプリケーションが保存したドメインの資格情報を隔離する Windows の機能。Active Directory のデータベースと SAM は保護しない。

**LSA protection（RunAsPPL）**：保護されていないプロセスが LSA のメモリを読むことと、コードを注入することを防ぐ Windows の設定。

**AMSI（Antimalware Scan Interface）**：スクリプトやマクロの内容を、端末に導入されたマルウェア対策製品へ渡して検査させる Windows のインタフェース。PowerShell、Windows Script Host、Office の VBA などが連携する。

**ASR（攻撃面の削減、Attack Surface Reduction）**：悪用されやすいソフトウェアの挙動を対象に、遮断または記録を行う Microsoft Defender の規則群。遮断せずに記録だけを取る監査モードを持つ。

**改ざん防止（Tamper Protection）**：セキュリティ設定の無効化と変更を防ぐ Microsoft Defender の機能。除外設定の追加も止まるため、攻撃側の操作が管理コンソール側の記録に変わる。

**BYOVD（Bring Your Own Vulnerable Driver）**：既知の脆弱性を持つ正規の署名済みドライバを持ち込み、カーネルの権限を得る手口。Windows は脆弱なドライバのブロックリストで対処する（[Microsoft Defender と EDR の回避が成立する条件](../technology/windows/defense-evasion.md)）。

**Kerberoasting**：サービスプリンシパル名が設定されたアカウントのチケットを要求し、そのアカウントのパスワードから導かれた鍵をオフラインで解く手法。

**AD CS（Active Directory 証明書サービス）**：ドメイン内で証明書を発行する Windows の役割。テンプレートと対応づけの設定が緩いと、低い権限の利用者が別の利用者として認証できる証明書を正規の手続きで得られる。

**LAPS（Local Administrator Password Solution）**：端末ごとにローカル管理者のパスワードを自動生成して管理する Windows の機能。共通パスワードによる水平展開を断つ。

**OSED（Offensive Security Exploit Developer）**：OffSec の EXP-301（Windows User Mode Exploit Development）に対応する認定。Windows のユーザモードのアプリケーションで、メモリ破壊の欠陥を悪用まで持っていく手順を扱う（[Windows アプリケーションのセキュリティ](../technology/windows/app-security.md)）。

**CRTE（Certified Red Team Expert）**：Altered Security の Windows Red Team Lab に対応する認定。複数のドメインとフォレストで構成された Active Directory 環境での、列挙、権限昇格、横展開、永続化と、その検知および回避を扱う。

**二重恐喝（Double Extortion）**：暗号化に加えて、窃取したデータの公開を材料に金銭を要求する手口。

**RaaS（Ransomware as a Service）**：ランサムウェアを開発する集団が、実行役（アフィリエイト）に提供して収益を分配する形態。

**ISAC（Information Sharing and Analysis Center）**：業界ごとに脅威情報を共有する組織。

**IOC（Indicator of Compromise）**：侵害の痕跡。IP アドレス、ハッシュ値、ドメイン名など。

**TTPs（Tactics, Techniques, and Procedures）**：攻撃者の戦術、技術、手順。IOC より変化しにくく、防御設計の基礎になる。

**SBOM（Software Bill of Materials）**：ソフトウェア部品表。製品に含まれるコンポーネントとそのバージョンの一覧。脆弱性が公表されたときに影響範囲を判断するための前提になる。

**CVD（Coordinated Vulnerability Disclosure）**：発見者、開発者、調整機関が公表の時期を調整して脆弱性を開示する枠組み。医療機器では、薬事上の手続きを含むため猶予期間が長くなりやすい。

**VDP（Vulnerability Disclosure Policy）**：外部からの脆弱性報告を受け付けることを表明し、受付窓口と対応方針を公開する文書。報奨金の有無とは独立した仕組みである。

---

## 規制

**三省二ガイドライン**：厚生労働省のガイドラインと、経済産業省および総務省のガイドラインをあわせた通称。医療情報を扱う際の国内の基本的な枠組み。

**薬機法**：医薬品、医療機器等の品質、有効性及び安全性の確保等に関する法律。医療機器の規制の根拠となる。

**QMS 省令**：医療機器の製造管理と品質管理の基準を定めた省令。

**PMDA（医薬品医療機器総合機構）**：医療機器の審査と安全対策を担う国内の機関。

**HIPAA**：米国の医療情報保護に関する法律。Privacy Rule、Security Rule、Breach Notification Rule からなる。

**FD&C Act 524B**：米国で医療機器の市販前提出にサイバーセキュリティ情報の提出を義務づける条項。

**MDR（Medical Device Regulation）**：EU の医療機器規則。

**NIS2**：EU の重要インフラ向け指令。医療分野を対象に含む。

**IMDRF（International Medical Device Regulators Forum）**：各国の医療機器規制当局による国際的な枠組み。各国のガイダンスの基礎になっている。

---

<sub>[トップへ](../../README.md)</sub>
