# Codex Skills Backup

このリポジトリは、Codexで使う個人スキルのバックアップ用です。

## 方針

- スキル本体はGitHubの非公開リポジトリで管理する。
- Notionは「目録」「使い方」「リンク集」として使う。
- PCを変えるときは、このリポジトリの `skills/` 配下を新PCの `.codex/skills/` に戻す。

## 収録スキル

| Skill | Purpose |
|---|---|
| `relife-art-carousel-chatgpt` | Relife Art / 魂のレシピデザインでInstagramカルーセル画像をChatGPT内生成し、検品する |
| `coconala-blog-oneclick` | ココナラ商品ページからブログ記事、画像3枚、未公開下書き保存、再オープン検証まで行う |
| `coconala-blog-image-generator` | ワンクリック卓から画像プロンプトを抽出し、ChatGPT画像生成と検品を行う |

## GitHubに保存する手順

1. GitHubで private repository を作る。例: `codex-skills-backup`
2. このフォルダをリポジトリとして初期化する。
3. `skills/`、`README.md`、`RESTORE.md`、`notion-index.csv` をコミットする。

```powershell
git init
git add .
git commit -m "Add Codex skills backup"
git branch -M main
git remote add origin https://github.com/YOUR_NAME/codex-skills-backup.git
git push -u origin main
```

## Notionで管理するもの

Notionには `notion-index.csv` をインポートして、各スキルの用途・呼び出し文・保管先URLを管理する。

本体コードはNotionに貼り付けず、GitHub側を正とする。
