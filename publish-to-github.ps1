param(
  [string]$RepoName = "codex-skills-backup",
  [string]$Visibility = "public",
  [string]$GitHubUser = ""
)

$ErrorActionPreference = "Stop"

function Find-Git {
  $bundled = "C:\Users\suket\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe"
  if (Test-Path -LiteralPath $bundled) { return $bundled }
  $cmd = Get-Command git -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  throw "git was not found. Please check Codex bundled Git or installed Git."
}

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$git = Find-Git

Set-Location -LiteralPath $repoDir

if (-not (Test-Path -LiteralPath ".git")) {
  & $git init
}

& $git branch -M main

$configuredName = & $git config user.name 2>$null
if (-not $configuredName) {
  & $git config user.name "Codex Backup"
}
$configuredEmail = & $git config user.email 2>$null
if (-not $configuredEmail) {
  & $git config user.email "codex-backup@example.local"
}

& $git add .
$status = & $git status --porcelain
if ($status) {
  & $git commit -m "Update Codex skills backup"
}

$gh = Get-Command gh -ErrorAction SilentlyContinue
if ($gh) {
  Write-Host "GitHub CLI found. Creating a GitHub repository and pushing."
  $visibilityFlag = if ($Visibility -eq "public") { "--public" } else { "--private" }
  & gh repo create $RepoName $visibilityFlag --source . --remote origin --push
  Write-Host "Done: pushed to GitHub."
  exit 0
}

if (-not $GitHubUser) {
  $GitHubUser = Read-Host "Enter your GitHub username"
}

$remoteUrl = "https://github.com/$GitHubUser/$RepoName.git"
$newRepoUrl = "https://github.com/new?name=$RepoName&visibility=$Visibility"

Write-Host ""
Write-Host "GitHub CLI was not found. Opening the GitHub new repository page."
Write-Host "Repository name: $RepoName"
Write-Host "Visibility: $Visibility"
Write-Host ""
Start-Process $newRepoUrl
Read-Host "Create the repository in the browser, then press Enter here"

$existingRemote = & $git remote
if ($existingRemote -contains "origin") {
  & $git remote set-url origin $remoteUrl
} else {
  & $git remote add origin $remoteUrl
}

Write-Host "Pushing now. If GitHub asks you to sign in, complete the authentication."
& $git push -u origin main

Write-Host ""
Write-Host "Done: $remoteUrl"
