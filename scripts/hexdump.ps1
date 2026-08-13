if ($args.Count -lt 2) {
    Write-Host "Usage: hexdump <file> [width]" -ForegroundColor Yellow
    exit 1
}

# args[1] = file path
$Path = $args[1]

# args[2] = width (optional)
$Width = 16
if ($args.Count -ge 3) {
    if ([int]::TryParse($args[2], [ref]$null)) {
        $Width = [int]$args[2]
    }
}

if (-not (Test-Path $Path)) {
    Write-Host "[ERROR] File not found: $Path" -ForegroundColor Red
    exit 1
}

$bytes = [System.IO.File]::ReadAllBytes($Path)
$offset = 0
$length = $bytes.Length

$bytes = [System.IO.File]::ReadAllBytes($Path)
$offset = 0
$length = $bytes.Length

# Legend (already in your output)
Write-Host "Legend:" -ForegroundColor White
Write-Host "  " -NoNewline; Write-Host "00" -ForegroundColor DarkGray -NoNewline; Write-Host "  = Null byte"
Write-Host "  " -NoNewline; Write-Host "41" -ForegroundColor Cyan -NoNewline; Write-Host "  = Printable ASCII"
Write-Host "  " -NoNewline; Write-Host "FF" -ForegroundColor Yellow -NoNewline; Write-Host "  = Non-printable / binary data"
Write-Host ""

# -------------------------
#   AUTO‑SIZED SEPARATOR
# -------------------------
$hexSection = "-" * ($Width * 3)
$asciiSection = "-" * $Width
$separator = "Offset---" + $hexSection + "--" + $asciiSection
Write-Host $separator

Write-Host ("Offset".PadRight(10) + "Hex".PadRight($Width * 3) + "ASCII")

while ($offset -lt $length) {
    $end   = [Math]::Min($offset + $Width - 1, $length - 1)
    $chunk = $bytes[$offset..$end]

    $ascii = ""
    $lineOffset = "{0:X8}" -f $offset

    # print offset
    Write-Host -NoNewline ($lineOffset + "  ")

    # print hex bytes with color
    foreach ($b in $chunk) {
        $hexByte = "{0:X2} " -f $b

        if ($b -eq 0) {
            # null bytes
            Write-Host -NoNewline $hexByte -ForegroundColor DarkGray
        } elseif ($b -ge 32 -and $b -le 126) {
            # printable ASCII
            Write-Host -NoNewline $hexByte -ForegroundColor Cyan
        } else {
            # other bytes
            Write-Host -NoNewline $hexByte -ForegroundColor Yellow
        }

        if ($b -ge 32 -and $b -le 126) {
            $ascii += [char]$b
        } else {
            $ascii += "."
        }
    }

    # pad remaining hex space if last line is short
    $remaining = $Width - $chunk.Count
    if ($remaining -gt 0) {
        Write-Host -NoNewline ("   " * $remaining)
    }

    # space before ASCII
    Write-Host -NoNewline "  "

    # ASCII (single color)
    Write-Host $ascii

    $offset += $Width
}