$tool = $args[1]

function Get-Tool {
    param([string]$tool)

    $cmd = Get-Command $tool -ErrorAction SilentlyContinue

    if ($cmd) {
        Write-Host "[Successful] $tool found at $($cmd.Source)" -ForegroundColor Green

        try {
            $version = & $tool --version
            Write-Host "     Version: $version" -ForegroundColor Cyan
        }
        catch {
            Write-Host "     Version flag not supported" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "[ERROR] $tool not found in PATH" -ForegroundColor Red
    }
}

Write-Host "=== Checking $tool Installation ===" -ForegroundColor Magenta
Get-Tool $tool