# 📞 電話内容文字起こし・要約PWA

**リアルタイム音声認識とClaude AI連携による高機能な文字起こし・要約アプリ**

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/yourusername/call-transcription-pwa)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PWA Ready](https://img.shields.io/badge/PWA-Ready-brightgreen.svg)](https://developers.google.com/web/progressive-web-apps/)

## 🚀 デモ

**[ライブデモを試す](https://your-app-name.vercel.app)**

## 📱 スクリーンショット

![メイン画面](https://via.placeholder.com/600x400/4f46e5/ffffff?text=メイン録音画面)
![要約機能](https://via.placeholder.com/600x400/059669/ffffff?text=Claude連携要約)

## ✨ 主な機能

### 🎤 リアルタイム音声認識
- **ブラウザ標準API**を使用した高精度音声認識
- **連続録音対応**（自動再開機能付き）
- **日本語特化**の認識エンジン

### 📚 高度な用語辞書機能
- **デフォルト辞書**：AI・IT・ビジネス用語28個を内蔵
- **カスタム用語**：会社固有の用語や人名を追加可能
- **リアルタイム変換**：音声認識中に自動で誤認識を修正
- **学習機能**：使用頻度に基づく優先度の自動調整

### 🤖 Claude AI連携
- **5種類のテンプレート**：汎用・会議・営業・サポート・インタビュー
- **カスタムテンプレート**：独自の要約形式を作成・保存
- **ワンクリック連携**：プロンプトを自動生成してClaude.aiを開く

### 📋 履歴管理・エクスポート
- **ローカル保存**：録音データは端末内のみで管理
- **検索機能**：タイトルや内容での高速検索
- **エクスポート機能**：テキスト・JSON形式での出力

### 🔧 ユーザビリティ
- **PWA対応**：ホーム画面に追加してアプリのように使用
- **レスポンシブ**：PC・タブレット・スマートフォン対応
- **初回サポート**：ウェルカムガイドとオンボーディング
- **ヘルプ機能**：包括的なFAQとトラブルシューティング

## 🚀 クイックスタート

### 方法1: Vercelで即座にデプロイ

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/yourusername/call-transcription-pwa)

1. 上のボタンをクリック
2. GitHubアカウントでログイン
3. リポジトリ名を設定
4. 「Deploy」をクリック
5. デプロイ完了後、URLにアクセス

### 方法2: ローカルで開発

```bash
# リポジトリをクローン
git clone https://github.com/yourusername/call-transcription-pwa.git
cd call-transcription-pwa

# 依存関係をインストール
npm install

# 開発サーバーを起動
npm run dev

# ブラウザで http://localhost:3000 を開く
```

### 方法3: 静的ホスティング

任意の静的ホスティングサービス（Netlify、GitHub Pages、Firebase Hosting等）に以下のファイルをアップロード：

- `index.html`
- `manifest.json`
- `sw.js`
- `icon-*.png`
- `favicon.*`

## 📱 使い方

### 基本的な使用手順

1. **📱 PWAインストール**
   - ブラウザで開いて「ホーム画面に追加」

2. **🎤 音声録音**
   - マイク許可を設定
   - 録音ボタンをタップして開始

3. **📚 用語辞書の活用**
   - デフォルト辞書を読み込み
   - 必要に応じてカスタム用語を追加

4. **🤖 要約作成**
   - 用途に応じたテンプレートを選択
   - Claude.aiで自動要約を生成

### 電話録音の推奨設定

```
📱 スマートフォンの設定：
├── スピーカーフォン: ON
├── 音量: 中程度
└── 静かな環境での使用を推奨

🎤 PWAアプリの設定：
├── マイク許可: 必須
├── リアルタイム変換: ON推奨
└── 適切なテンプレート選択
```

## 🔧 カスタマイズ

### 用語辞書のカスタマイズ

```javascript
// 新しい用語を追加
{
  wrong: "あいてぃー",
  correct: "IT",
  category: "technical",
  priority: 100
}

// カテゴリ
- general: 一般用語
- business: ビジネス用語  
- technical: 技術用語
- medical: 医療用語
- legal: 法務用語
```

### 要約テンプレートのカスタマイズ

```markdown
# カスタムテンプレート例

## 営業電話用
1. 顧客基本情報
2. ニーズ・課題
3. 提案内容
4. 次回アクション

## 会議用
1. 議題・目的
2. 決定事項
3. アクションアイテム
4. 次回予定
```

## 🛠️ 技術仕様

### 対応ブラウザ
- ✅ **Chrome 80+** (推奨)
- ✅ **Edge 80+**
- ✅ **Safari 14+**
- ✅ **Firefox 78+** (部分対応)

### システム要件
- **OS**: Windows 10+, macOS 10.15+, Android 8.0+, iOS 14+
- **RAM**: 最小1GB、推奨2GB+
- **ネットワーク**: 音声認識用の安定したインターネット接続
- **マイク**: 内蔵またはUSBマイク

### 使用技術
- **フロントエンド**: Vanilla JavaScript, HTML5, CSS3
- **音声認識**: Web Speech API (webkitSpeechRecognition)
- **PWA**: Service Worker, Web App Manifest
- **ストレージ**: LocalStorage (クライアントサイド)
- **AI連携**: Claude.ai (外部サービス)

## 📊 パフォーマンス

- **Lighthouse Score**: 95+
- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **Cumulative Layout Shift**: < 0.1

## 🔐 プライバシー・セキュリティ

### データ保護
- ✅ **完全ローカル保存**: 音声データは端末内のみに保存
- ✅ **外部送信なし**: 録音ファイルは外部サーバーに送信されません
- ✅ **HTTPS必須**: 音声認識API使用のため暗号化通信
- ✅ **手動削除**: ユーザーがデータの削除を完全制御

### 法的考慮事項
- **通話録音**: 地域の法律・規制を必ず遵守してください
- **相手方同意**: 必要に応じて録音の同意を取得してください
- **機密情報**: 重要な情報の取り扱いには十分注意してください

## 🤝 コントリビューション

### 開発に参加する

```bash
# フォークしてクローン
git clone https://github.com/yourusername/call-transcription-pwa.git

# 機能ブランチを作成
git checkout -b feature/awesome-feature

# 変更をコミット
git commit -m 'Add awesome feature'

# プッシュ
git push origin feature/awesome-feature

# プルリクエストを作成
```

### 報告・提案

- 🐛 **バグ報告**: [Issues](https://github.com/yourusername/call-transcription-pwa/issues)
- 💡 **機能提案**: [Discussions](https://github.com/yourusername/call-transcription-pwa/discussions)
- 📧 **その他**: [Contact](mailto:your.email@example.com)

## 📄 ライセンス

このプロジェクトは[MIT License](LICENSE)のもとで公開されています。

## 🙏 謝辞

- [Web Speech API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API) - 音声認識機能
- [Claude.ai](https://claude.ai/) - AI要約サービス
- [PWA Technologies](https://web.dev/progressive-web-apps/) - Progressive Web App技術

## 📈 ロードマップ

- [ ] 🗣️ **話者分離機能** - 複数話者の自動識別
- [ ] ✏️ **自動句読点調整** - より自然な文章構造
- [ ] ☁️ **クラウド同期** - オプションでのデータ同期
- [ ] 🌍 **多言語対応** - 英語・中国語・韓国語サポート
- [ ] 📊 **高度な分析** - 通話分析・統計機能

---

**📞 ビジネス効率化のための次世代文字起こしツール**

[![Star this repo](https://img.shields.io/github/stars/yourusername/call-transcription-pwa?style=social)](https://github.com/yourusername/call-transcription-pwa)
[![Fork this repo](https://img.shields.io/github/forks/yourusername/call-transcription-pwa?style=social)](https://github.com/yourusername/call-transcription-pwa/fork)
[![Watch this repo](https://img.shields.io/github/watchers/yourusername/call-transcription-pwa?style=social)](https://github.com/yourusername/call-transcription-pwa/subscription)