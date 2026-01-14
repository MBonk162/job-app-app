# PowerShell script to create Android signing keystore
# Run this from PowerShell: .\create_keystore.ps1

Write-Host "Creating Android signing keystore..." -ForegroundColor Cyan
Write-Host ""
Write-Host "You'll be asked for:"
Write-Host "  - Keystore password (remember this!)"
Write-Host "  - Key alias password (can be same as keystore password)"
Write-Host "  - Your name, organization, etc."
Write-Host ""

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$keystorePath = Join-Path $scriptDir "app\upload-keystore.jks"

Write-Host "Keystore will be created at: $keystorePath" -ForegroundColor Yellow
Write-Host ""

# Try to find keytool
$keytoolPaths = @(
    "keytool",  # Try from PATH first
    "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe",
    "C:\Program Files\Java\jdk-*\bin\keytool.exe"
)

$keytool = $null
foreach ($path in $keytoolPaths) {
    if (Get-Command $path -ErrorAction SilentlyContinue) {
        $keytool = $path
        Write-Host "Found keytool at: $keytool" -ForegroundColor Green
        break
    }
}

if (-not $keytool) {
    Write-Host "ERROR: keytool not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "keytool is part of the Java JDK. Please ensure:"
    Write-Host "1. Java JDK is installed"
    Write-Host "2. keytool is in your PATH"
    Write-Host ""
    Write-Host "If you have Android Studio, keytool is usually at:"
    Write-Host 'C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe'
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Create the keystore
Write-Host ""
Write-Host "Running keytool..." -ForegroundColor Cyan
& $keytool -genkey -v -keystore $keystorePath -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Check if the file was created
if (Test-Path $keystorePath) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! Keystore created at:" -ForegroundColor Green
    Write-Host $keystorePath -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "IMPORTANT: Keep this file and passwords safe!" -ForegroundColor Red
    Write-Host "You'll need them for all future app updates." -ForegroundColor Red
    Write-Host ""

    # Show file info
    $fileInfo = Get-Item $keystorePath
    Write-Host "File size: $($fileInfo.Length) bytes"
    Write-Host "Created: $($fileInfo.CreationTime)"
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "ERROR: Keystore file was not created!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "The keytool command may have failed."
    Write-Host "Check the error messages above."
}

Write-Host ""
Read-Host "Press Enter to exit"
