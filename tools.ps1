Clear-Host
Write-Host "=== IT Support Toolkit ==="
Write-Host "1. Check Network Connection"
Write-Host "2. Show System Info"
Write-Host "3. Check Disk Space"
Write-Host "4. View Recent System Errors"
Write-Host "5. Exit"

$choice = Read-Host "Choose an option"

switch ($choice) {

    1 {
        Write-Host "`n--- Network Check ---"
        Test-Connection -ComputerName "microsoft.com" -Count 2
    }

    2 {
        Write-Host "`n--- System Info ---"
        Get-ComputerInfo | Select-Object WindowsVersion, CsName, OsArchitecture, CsProcessors, CsTotalPhysicalMemory
    }

    3 {
        Write-Host "`n--- Disk Space ---"
        Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
    }

    4 {
        Write-Host "`n--- Recent System Errors ---"
        Get-EventLog -LogName System -EntryType Error -Newest 10
    }

    5 {
        Write-Host "Goodbye!"
        exit
    }

    default {
        Write-Host "Invalid choice"
    }
}