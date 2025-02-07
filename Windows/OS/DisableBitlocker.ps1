Disable-Bitlocker -MountPoint "C:"
while ($true) {
    $BitlockerStatus = Get-BitlockerVolume -MountPoint "C:"
    if ($BitlockerStatus.VolumeStatus -eq "FullyDecrypted") {
        break
    }
    else {
    $v = 100 - $BitlockerStatus.EncryptionPercentage
    #Write-Host "Waiting for Bitlocker to be disabled... Status: $($v)% complete."
    Write-Progress -Activity "Disabling Bitlocker" -Status "Waiting for Bitlocker to be disabled... Status: $($v)% complete." -PercentComplete $v
    Start-Sleep -Seconds 5
    }
}
