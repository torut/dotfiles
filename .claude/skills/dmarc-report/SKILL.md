---
name: dmarc-report
description: DMARCレポート(集計レポート)のXMLファイルを読み込み、人が読みやすいレポートに整形する。送信元ドメイン別に分類し、送信元メールサーバ(IP)・レポート・送信先ドメインで階層化して report ディレクトリに保存する。ユーザーが「DMARCレポートを作成」「xmlを集計してレポートに」等と依頼したときに使用。
---

# DMARCレポート整形スキル

DMARC集計レポート(RUA)のXMLファイル群を読み込み、人が読みやすいMarkdownレポートに整形して保存する。

## 入出力

- 入力: `xml/` ディレクトリ内の DMARC 集計レポート XMLファイル
  - ファイル名は通常 `<reporter>!<domain>!<begin>!<end>.xml` 形式(例: `enterprise.protection.outlook.com!example.jp!1780876800!1780963200.xml`)
- 出力: `report/` ディレクトリに **送信元ドメイン別** のMarkdownファイル(例: `report/example.jp.md`)

## 分類の階層(必ずこの順で入れ子にする)

1. **送信元ドメイン名** 別に分類
   - `policy_published/domain`(= `header_from`)。出力ファイルもこの単位で1ファイル。
2. 同一送信元ドメインの中で **送信元メールサーバ** に分類
   - `record/row/source_ip`
3. 同一メールサーバの中で **レポート(レポート提供元・集計期間)** 別に分類
   - `report_metadata/org_name` + `date_range`(JST)。レポート提供元と集計期間でグループ化する。
4. 同一レポートの中で **送信先ドメイン別** に分類
   - `record/identifiers/envelope_to`
   - `envelope_to` が無いレポート(Google / Yahoo / 一部サーバ)は「(記載なし)」とする

## ルール

- **レポートの日付は日本標準時(JST / UTC+9)で表示**する。
  - `date_range/begin` と `end` はUnix秒。変換コマンド例:
    ```bash
    TZ='Asia/Tokyo' date -d @<unixtime> '+%Y-%m-%d %H:%M:%S %Z'
    ```
- **表組み(テーブル)は使わず、リスト**で表現する。
- **絵文字は使わない**(注意喚起は「注意:」「警告:」などのテキストで表す)。
- 同一の送信元ドメインに対して **複数のレポート提供元(Microsoft / Google / Yahoo / wadax 等)** がある場合は、すべて同じ送信元ドメインのファイルに統合する。
  - 各レポートのメタ情報(発行元・レポートID・集計期間(JST))を「レポート概要」に列挙する。
  - 明細は 送信元IP → レポート(提供元・期間) → 送信先ドメイン の入れ子で組み立てる。同じ送信元IPが複数レポートに登場する場合は、IPの下に各レポートを並べる。
- 各明細(送信先ドメインの末端)には少なくとも以下を出す:
  - 件数(`count`)、処理結果(`policy_evaluated/disposition`)、DKIM結果、SPF結果
  - 認証が失敗している場合は `auth_results` の詳細(認証ドメイン・selector・softfail等)を注記する
- DKIM/SPFのどちらか一方でもアライン合格していればDMARCは合格である点を踏まえ、誤解のないよう注記する。

## 実行手順

1. `ls xml/` で対象XMLを列挙し、各ファイルを読み込む。
2. ファイルごとに `policy_published/domain`(送信元ドメイン)、各 `record`(source_ip / envelope_to / count / disposition / dkim / spf / auth_results)、`report_metadata`(org_name / email / report_id / date_range)を抽出する。
3. `date_range` を上記コマンドでJSTに変換する。
4. 送信元ドメインごとにレコードを集約し、source_ip → レポート(提供元・期間) → envelope_to の順で入れ子のリストを組み立てる。
5. `mkdir -p report` の上、送信元ドメインごとに `report/<domain>.md` を書き出す。
6. 認証失敗・DMARC不合格の通信があれば「補足」として要約し、ユーザーに報告する。

## 出力フォーマット例

```markdown
# DMARCレポート: example.jp

## レポート概要

- 集計対象レポート: 2件
  - Enterprise Outlook (dmarcreport@microsoft.com)
    - レポートID: xxxxxxxx
    - 集計期間(JST): 2026-06-08 09:00:00 ～ 2026-06-09 09:00:00
  - google.com (noreply-dmarc-support@google.com)
    - レポートID: yyyyyyyy
    - 集計期間(JST): 2026-06-09 09:00:00 ～ 2026-06-10 08:59:59
- 公開ポリシー: p=none / sp=none / adkim=r / aspf=r / pct=100
- 総メッセージ数: 55通 (Enterprise Outlook 23通 + google.com 32通)

## 送信元メールサーバ別 詳細

- 送信元メールサーバ: 52.192.224.240
  - レポート: Enterprise Outlook (2026-06-08 09:00:00 ～ 2026-06-09 09:00:00 JST)
    - 送信先ドメイン: example-to.jp
      - 件数: 1 / 処理: none / DKIM: pass / SPF: pass
  - レポート: google.com (2026-06-09 09:00:00 ～ 2026-06-10 08:59:59 JST)
    - 送信先ドメイン: (記載なし)
      - 件数: 6 / 処理: none / DKIM: pass / SPF: fail
      - 注意: SPF未アラインだがDKIMが合格のためDMARCは合格。

## 補足

- 警告: <IP> からの N 通はDKIM・SPFともに失敗。送信元の正当性を確認すること。
```

## 注意

- XMLは提供元によって書式差がある(`envelope_to` の有無、`fo`/`np` 等の任意要素、タブ/全角の混入など)。要素が無くてもエラーにせず「(記載なし)」等で扱う。
- 既存の `report/<domain>.md` がある場合は最新のXML群で作り直す(上書き)。
