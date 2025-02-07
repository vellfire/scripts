$filesToRemove = @(
    "$env:SystemRoot\System32\Mictray64.exe",
    "$env:SystemRoot\System32\Mictray.exe",
    "$env:SystemRoot\System32\Mictray64.xml",
    "$env:SystemRoot\System32\Mictray.xml",
    "$env:SystemDrive\Users\Public\MicTray.log",
    "$env:SystemDrive\SWSETUP\DRV\Audio\Conexant",
    "$env:SystemDrive\SWSETUP\sp78909\Audio",
    "$env:SystemRoot\UCI\Rollback\oem21.inf\MicTray.cab",
    "$env:SystemRoot\UCI\Rollback\oem60.inf\MicTray.cab"
)

foreach ($file in $filesToRemove) {
    if (Test-Path $file) {
        Write-Output "Found $file"
        if ($file -like "*.exe") {
            $processName = [System.IO.Path]::GetFileNameWithoutExtension($file)
            Stop-Process -Name $processName -Force
            Start-Sleep -Seconds 2
        }
        Remove-Item -Path $file -Force -Recurse
    }
}

if ($scheduledTasks = Get-ScheduledTask | Where-Object TaskName -match 'MicTray') {
    Write-Output 'Found scheduled task'
    $scheduledTasks | Unregister-ScheduledTask -Confirm:$false
}
