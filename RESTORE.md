# Restore Guide

PCを変えたあとにCodexスキルを戻す手順です。

## 1. リポジトリを取得

```powershell
git clone https://github.com/peroperocandy0607-collab/codex-skills-backup.git
cd codex-skills-backup
```

## 2. スキルを配置

新PCのユーザー名に合わせて、以下を実行します。

```powershell
$codexSkills = "$env:USERPROFILE\.codex\skills"
New-Item -ItemType Directory -Path $codexSkills -Force
Copy-Item -Path ".\skills\*" -Destination $codexSkills -Recurse -Force
```

## 3. Codexを再起動

Codexアプリを再起動し、スキル一覧に戻っているか確認します。

## 4. 確認すること

- `relife-art-carousel-chatgpt` がある
- `coconala-blog-oneclick` がある
- `coconala-blog-image-generator` がある
- 各フォルダに `SKILL.md` がある
- `references/` や `agents/` も一緒に戻っている

## 注意

`.codex/plugins/cache/` はプラグインのキャッシュなので、このバックアップの主対象にはしません。
個人作成スキルは `.codex/skills/` 配下を正として扱います。
