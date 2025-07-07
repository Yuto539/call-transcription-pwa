# 🚀 MCPを活用したGitHub配布ガイド

MCPツールでGitHubへの直接アクセスはできませんが、**自動化スクリプト**を作成しました！

## 📂 作成された自動化ツール

### 🎯 **選択肢1: GitHub CLI使用（推奨）**
```bash
# PowerShell版（高機能・カラフル出力）
github-deploy.ps1

# バッチファイル版（シンプル）
github-deploy-cli.bat
```

### 🎯 **選択肢2: 手動Git操作**
```bash
# 基本的なGit操作
github-deploy.bat
```

## 🚀 最も簡単な方法：PowerShellスクリプト

### 1. **PowerShellで実行**
```powershell
# PowerShellを管理者として開く
cd "C:\Users\uto92\Dev\SendCall"

# 実行ポリシーを一時的に変更（必要な場合）
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# スクリプト実行
.\github-deploy.ps1
```

### 2. **自動で実行される処理**
- ✅ GitHub CLI の確認・認証
- ✅ README ファイルのリネーム
- ✅ Git 初期化
- ✅ GitHubリポジトリ自動作成
- ✅ 配布用ファイルのみを選択的に追加
- ✅ 自動コミット・プッシュ
- ✅ Vercel配布ページを自動オープン

## 🔧 事前準備（初回のみ）

### GitHub CLI のインストール
```bash
# 方法1: 公式サイトからダウンロード
https://cli.github.com/

# 方法2: Winget使用
winget install --id GitHub.cli

# 方法3: Chocolatey使用
choco install gh
```

### Git の確認
```bash
git --version
```

## 📋 手動実行手順（バックアップ方法）

### 1. README リネーム
```bash
move README-github.md README.md
```

### 2. Git 操作
```bash
git init
git add index.html manifest.json sw.js vercel.json package.json LICENSE .gitignore README.md DEPLOY-GUIDE.md icon-*.png favicon.*
git commit -m "Initial commit: 電話内容文字起こし・要約PWA"
```

### 3. GitHub リポジトリ作成
- https://github.com/new でリポジトリ作成
- リポジトリ名: `call-transcription-pwa`

### 4. プッシュ
```bash
git remote add origin https://github.com/yourusername/call-transcription-pwa.git
git push -u origin main
```

### 5. Vercel デプロイ
- https://vercel.com/new にアクセス
- 作成したリポジトリを選択
- "Deploy" をクリック

## ⚡ ワンクリック実行

最も簡単な方法：

```powershell
# PowerShellを開いて1行実行
cd "C:\Users\uto92\Dev\SendCall" && powershell -ExecutionPolicy Bypass -File github-deploy.ps1
```

## 🎉 実行結果

スクリプト実行後に得られるもの：

- ✅ **GitHubリポジトリ**: `https://github.com/yourusername/call-transcription-pwa`
- ✅ **Vercel配布URL**: `https://call-transcription-pwa.vercel.app`
- ✅ **PWA機能**: ホーム画面への追加可能
- ✅ **自動デプロイ**: GitHubプッシュで自動更新

## 🔍 トラブルシューティング

### GitHub CLI 認証エラー
```bash
gh auth logout
gh auth login
```

### Git 認証エラー
```bash
# SSH設定またはPersonal Access Token設定
git config --global credential.helper manager-core
```

### PowerShell実行ポリシーエラー
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

**🚀 準備完了！PowerShellスクリプトを実行すれば、数分でGitHub+Vercel配布が完了します！**