function Get-Tool {
    param([string]$tool)

    if (& where.exe $tool $null) {
        $version = & $tool --version
        Write-Host "✅ $tool found: $version"
    }
    else {
        Write-Host "❌ $tool not found in PATH"
    }
}

Write-Host "=== Checking Rust and Cargo Installation ==="
Get-Tool rustc
Get-Tool cargo