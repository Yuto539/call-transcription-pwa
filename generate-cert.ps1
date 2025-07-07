Write-Host "========================================" -ForegroundColor Green
Write-Host "  🔐 HTTPS証明書を生成中..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

try {
    # 自己署名証明書の生成
    $cert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "cert:\LocalMachine\My" -KeyAlgorithm RSA -KeyLength 2048 -NotAfter (Get-Date).AddYears(10)
    
    # 証明書をPFXファイルにエクスポート
    $password = ConvertTo-SecureString -String "password" -Force -AsPlainText
    $pfxPath = "server.pfx"
    Export-PfxCertificate -Cert $cert -FilePath $pfxPath -Password $password
    
    Write-Host "✅ 証明書が生成されました" -ForegroundColor Green
    Write-Host "📁 ファイル: server.pfx" -ForegroundColor Yellow
    Write-Host "🔑 パスワード: password" -ForegroundColor Yellow
    Write-Host ""
    
} catch {
    Write-Host "❌ PowerShellでの証明書生成に失敗しました" -ForegroundColor Red
    Write-Host "🔄 Node.js方式で証明書を生成します..." -ForegroundColor Yellow
    Write-Host ""
    
    # Node.jsを使用した証明書生成にフォールバック
    node generate-cert.js
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "  🚀 証明書生成完了！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green