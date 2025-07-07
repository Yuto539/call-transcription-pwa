# GitHub + Vercel 自動デプロイスクリプト (PowerShell)
param(
    [string]$RepoName = "call-transcription-pwa",
    [string]$RepoDescription = "📞 電話内容文字起こし・要約PWA - リアルタイム音声認識とClaude AI連携"
)

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "GitHub + Vercel 自動デプロイスクリプト" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# 現在のディレクトリ確認
Write-Host "📂 現在のディレクトリ: $(Get-Location)" -ForegroundColor Green
Write-Host ""

# GitHub CLI の確認
Write-Host "🔧 GitHub CLI の確認中..." -ForegroundColor Yellow
try {
    $ghVersion = gh --version
    Write-Host "✅ GitHub CLI が利用可能です: $($ghVersion[0])" -ForegroundColor Green
} catch {
    Write-Host "❌ GitHub CLI がインストールされていません" -ForegroundColor Red
    Write-Host "📥 以下のURLからインストールしてください:" -ForegroundColor Yellow
    Write-Host "https://cli.github.com/" -ForegroundColor Blue
    Read-Host "インストール後、Enterキーを押してください"
    exit 1
}
Write-Host ""

# GitHub 認証確認
Write-Host "🔐 GitHub 認証確認中..." -ForegroundColor Yellow
try {
    $authStatus = gh auth status 2>&1
    if ($authStatus -match "not logged into") {
        Write-Host "❌ GitHub認証が必要です" -ForegroundColor Red
        Write-Host "🔑 認証を開始します..." -ForegroundColor Yellow
        gh auth login
    }
    Write-Host "✅ GitHub認証完了" -ForegroundColor Green
} catch {
    Write-Host "❌ GitHub認証に失敗しました" -ForegroundColor Red
    Read-Host "エラーを確認して、Enterキーを押してください"
    exit 1
}
Write-Host ""

# README リネーム
Write-Host "📝 README ファイルをリネーム中..." -ForegroundColor Yellow
if (Test-Path "README-github.md") {
    if (Test-Path "README.md") {
        Remove-Item "README.md" -Force
    }
    Rename-Item "README-github.md" "README.md"
    Write-Host "✅ README-github.md → README.md 完了" -ForegroundColor Green
} else {
    Write-Host "⚠️ README-github.md が見つかりません" -ForegroundColor Yellow
}
Write-Host ""

# Git 初期化
Write-Host "🔧 Git 初期化中..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init
    Write-Host "✅ Git 初期化完了" -ForegroundColor Green
} else {
    Write-Host "✅ Git は既に初期化されています" -ForegroundColor Green
}
Write-Host ""

# リポジトリ名の確認
$userInput = Read-Host "📂 GitHubリポジトリ名を入力してください (デフォルト: $RepoName)"
if ($userInput) {
    $RepoName = $userInput
}
Write-Host ""

# GitHub リポジトリ作成
Write-Host "🌐 GitHubリポジトリ '$RepoName' を作成中..." -ForegroundColor Yellow
try {
    gh repo create $RepoName --public --description $RepoDescription --clone=false
    Write-Host "✅ リポジトリ作成完了" -ForegroundColor Green
} catch {
    Write-Host "⚠️ リポジトリが既に存在するか、作成に失敗しました" -ForegroundColor Yellow
    Write-Host "既存のリポジトリを使用して続行します..." -ForegroundColor Yellow
}
Write-Host ""

# 配布用ファイルの追加
Write-Host "📦 配布用ファイルを追加中..." -ForegroundColor Yellow
$filesToAdd = @(
    "index.html",
    "manifest.json", 
    "sw.js",
    "vercel.json",
    "package.json",
    "LICENSE",
    ".gitignore",
    "README.md",
    "DEPLOY-GUIDE.md"
)

foreach ($file in $filesToAdd) {
    if (Test-Path $file) {
        git add $file
        Write-Host "  ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️ $file が見つかりません" -ForegroundColor Yellow
    }
}

# アイコンファイルを追加
Get-ChildItem "icon-*.png" -ErrorAction SilentlyContinue | ForEach-Object {
    git add $_.Name
    Write-Host "  ✅ $($_.Name)" -ForegroundColor Green
}

# ファビコンファイルを追加
Get-ChildItem "favicon.*" -ErrorAction SilentlyContinue | ForEach-Object {
    git add $_.Name
    Write-Host "  ✅ $($_.Name)" -ForegroundColor Green
}

Write-Host "✅ 配布用ファイルの追加完了" -ForegroundColor Green
Write-Host ""

# コミット
Write-Host "💾 コミット実行中..." -ForegroundColor Yellow
git commit -m "Initial commit: 電話内容文字起こし・要約PWA - GitHub+Vercel配布対応"
Write-Host "✅ コミット完了" -ForegroundColor Green
Write-Host ""

# ユーザー名取得とリモート設定
Write-Host "🔗 リモートリポジトリ設定中..." -ForegroundColor Yellow
$username = (gh api user).login
git remote remove origin 2>$null
git remote add origin "https://github.com/$username/$RepoName.git"
Write-Host "✅ リモートリポジトリ設定完了" -ForegroundColor Green
Write-Host ""

# プッシュ
Write-Host "🚀 GitHubにプッシュ中..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "🎉 GitHub配布完了！" -ForegroundColor Green
    Write-Host "📂 リポジトリ: https://github.com/$username/$RepoName" -ForegroundColor Blue
    Write-Host ""
    
    # Vercel自動デプロイ
    $deployVercel = Read-Host "🚀 Vercel自動デプロイを開始しますか？ (y/n)"
    if ($deployVercel -eq "y" -or $deployVercel -eq "Y") {
        Write-Host "🌐 Vercelページを開いています..." -ForegroundColor Yellow
        Start-Process "https://vercel.com/new/clone?repository-url=https://github.com/$username/$RepoName"
        Write-Host ""
        Write-Host "📋 Vercel設定手順:" -ForegroundColor Cyan
        Write-Host "1. GitHubアカウントでログイン" -ForegroundColor White
        Write-Host "2. プロジェクト名: $RepoName" -ForegroundColor White
        Write-Host "3. Framework Preset: Other (静的サイト)" -ForegroundColor White
        Write-Host "4. 'Deploy' をクリック" -ForegroundColor White
        Write-Host "5. 数分で https://$RepoName.vercel.app で公開" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "✅ 全ての作業が完了しました！" -ForegroundColor Green
    Write-Host ""
    Write-Host "🔗 配布URL (予定): https://$RepoName.vercel.app" -ForegroundColor Blue
} else {
    Write-Host "❌ プッシュに失敗しました" -ForegroundColor Red
    Write-Host "🔧 以下を確認してください:" -ForegroundColor Yellow
    Write-Host "- GitHub認証情報" -ForegroundColor White
    Write-Host "- リポジトリのアクセス権限" -ForegroundColor White
    Write-Host "- インターネット接続" -ForegroundColor White
}

Write-Host ""
Read-Host "完了。Enterキーを押して終了してください"