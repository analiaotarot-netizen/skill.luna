param(
  [string]$RepoName = "codex-skills-backup",
  [string]$Visibility = "private",
  [string]$GitHubUser = ""
)

$ErrorActionPreference = "Stop"

function Find-Git {
  $bundled = "C:\Users\suket\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe"
  if (Test-Path -LiteralPath $bundled) { return $bundled }
  $cmd = Get-Command git -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  throw "git が見つかりません。Codex同梱Gitまたは通常のGitを確認してください。"
}

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$git = Find-Git

Set-Location -LiteralPath $repoDir

if (-not (Test-Path -LiteralPath ".git")) {
  & $git init
}

& $git branch -M main

if (-not (& $git config user.name)) {
  & $git config user.name "Codex Backup"
}
if (-not (& $git config user.email)) {
  & $git config user.email "codex-backup@example.local"
}

& $git add .
$status = & $git status --porcelain
if ($status) {
  & $git commit -m "Update Codex skills backup"
}

$gh = Get-Command gh -ErrorAction SilentlyContinue
if ($gh) {
  Write-Host "GitHub CLI が見つかりました。非公開リポジトリを作成して push します。"
  $visibilityFlag = if ($Visibility -eq "public") { "--public" } else { "--private" }
  & gh repo create $RepoName $visibilityFlag --source . --remote origin --push
  Write-Host "完了: GitHub に push しました。"
  exit 0
}

if (-not $GitHubUser) {
  $GitHubUser = Read-Host "GitHubユーザー名を入力してください"
}

$remoteUrl = "https://github.com/$GitHubUser/$RepoName.git"
$newRepoUrl = "https://github.com/new?name=$RepoName&visibility=$Visibility"

Write-Host ""
Write-Host "GitHub CLI がないため、ブラウザで非公開リポジトリ作成ページを開きます。"
Write-Host "Repository name: $RepoName"
Write-Host "Visibility: $Visibility"
Write-Host ""
Start-Process $newRepoUrl
Read-Host "ブラウザでリポジトリを作成したら Enter を押してください"

$existingRemote = & $git remote
if ($existingRemote -contains "origin") {
  & $git remote set-url origin $remoteUrl
} else {
  & $git remote add origin $remoteUrl
}

Write-Host "pushします。GitHubログイン画面が出たら認証してください。"
& $git push -u origin main

Write-Host ""
Write-Host "完了: $remoteUrl"
