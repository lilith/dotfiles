# Windows to WSL Configuration Sync Script
# This PowerShell script syncs editor configurations from Windows to WSL

param(
    [string]$WslDistro = "Ubuntu"
)

$ErrorActionPreference = "Stop"

Write-Host "Windows to WSL Configuration Sync" -ForegroundColor Green
Write-Host "==================================`n" -ForegroundColor Green

# Get WSL user home directory
try {
    $wslHome = wsl -d $WslDistro -e bash -c "echo `$HOME" | Out-String
    $wslHome = $wslHome.Trim()
    Write-Host "WSL Home: $wslHome" -ForegroundColor Cyan
} catch {
    Write-Host "Error: Could not connect to WSL distribution '$WslDistro'" -ForegroundColor Red
    Write-Host "Available distributions:" -ForegroundColor Yellow
    wsl -l -v
    exit 1
}

# Determine dotfiles directory in WSL
$dotfilesDir = "$wslHome/dotfiles/wsl"

# Function to sync file to WSL
function Sync-ToWSL {
    param(
        [string]$SourcePath,
        [string]$DestPath,
        [string]$Description
    )
    
    if (Test-Path $SourcePath) {
        $wslDestPath = $DestPath -replace '\\', '/'
        
        # Create directory in WSL if it doesn't exist
        $destDir = Split-Path $wslDestPath -Parent
        wsl -d $WslDistro -e bash -c "mkdir -p '$destDir'"
        
        # Copy file to WSL
        $tempFile = [System.IO.Path]::GetTempFileName()
        Copy-Item $SourcePath $tempFile -Force
        wsl -d $WslDistro -e bash -c "cat > '$wslDestPath'" -RedirectStandardInput $tempFile
        Remove-Item $tempFile
        
        Write-Host "✓ Synced $Description" -ForegroundColor Green
    } else {
        Write-Host "⚠ Skipping $Description (source not found)" -ForegroundColor Yellow
    }
}

# Sync Cursor settings
Write-Host "`nSyncing Cursor configuration..." -ForegroundColor Yellow
$cursorAppData = "$env:APPDATA\Cursor\User"
if (Test-Path $cursorAppData) {
    Sync-ToWSL "$cursorAppData\settings.json" "$dotfilesDir/cursor/settings.json" "Cursor settings"
    if (Test-Path "$cursorAppData\extensions.json") {
        Sync-ToWSL "$cursorAppData\extensions.json" "$dotfilesDir/cursor/extensions.json" "Cursor extensions"
    }
}

# Sync Zed settings
Write-Host "`nSyncing Zed configuration..." -ForegroundColor Yellow
$zedConfig = "$env:APPDATA\Zed"
if (Test-Path $zedConfig) {
    Sync-ToWSL "$zedConfig\settings.json" "$dotfilesDir/zed/settings.json" "Zed settings"
    Sync-ToWSL "$zedConfig\keymap.json" "$dotfilesDir/zed/keymap.json" "Zed keymap"
}

# Sync Rider settings
Write-Host "`nSyncing Rider configuration..." -ForegroundColor Yellow
$jetbrainsConfig = "$env:APPDATA\JetBrains"
if (Test-Path $jetbrainsConfig) {
    $riderDirs = Get-ChildItem -Path $jetbrainsConfig -Filter "Rider*" -Directory | Sort-Object Name -Descending
    if ($riderDirs) {
        $latestRider = $riderDirs[0].FullName
        Sync-ToWSL "$latestRider\options\editor.xml" "$dotfilesDir/rider/editor.xml" "Rider editor settings"
        Write-Host "Note: For full Rider sync, use JetBrains Settings Sync feature" -ForegroundColor Yellow
    }
}

Write-Host "`nConfiguration sync completed!" -ForegroundColor Green
Write-Host "Note: Changes are now in your WSL dotfiles repository." -ForegroundColor Yellow
Write-Host "You can commit and push these changes to sync across machines." -ForegroundColor Yellow
