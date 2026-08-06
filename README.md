# Codex Skills Backup

このリポジトリは、Codexで使う個人スキルのバックアップ用です。
URLを開けば内容を確認できるよう、公開リポジトリ運用を前提にしています。

## 方針

- スキル本体はGitHubの公開リポジトリで管理する。
- Notionは「目録」「使い方」「リンク集」として使う。
- PCを変えるときは、このリポジトリの `skills/` 配下を新PCの `.codex/skills/` に戻す。

## 収録スキル

| Skill | Purpose |
|---|---|
| `relife-art-carousel-chatgpt` | Relife Art / 魂のレシピデザインでInstagramカルーセル画像をChatGPT内生成し、検品する |
| `coconala-blog-oneclick` | ココナラ商品ページからブログ記事、画像3枚、未公開下書き保存、再オープン検証まで行う |
| `coconala-blog-image-generator` | ワンクリック卓から画像プロンプトを抽出し、ChatGPT画像生成と検品を行う |

## GitHubに保存する手順

一番かんたんな方法は、このフォルダで次を1回実行することです。

```powershell
.\publish-to-github.ps1
```

GitHub CLI `gh` がある場合は、公開リポジトリを作ってそのままpushします。
`gh` がない場合は、GitHubの新規リポジトリ作成ページを開き、作成後にEnterを押すとpushします。

既定のリポジトリ名は `codex-skills-backup`、公開範囲は `public` です。

## Notionで管理するもの

Notionには `notion-index.csv` をインポートして、各スキルの用途・呼び出し文・保管先URLを管理する。

本体コードはNotionに貼り付けず、GitHub側を正とする。
