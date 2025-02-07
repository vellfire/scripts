Write-Output "Removing all copies of TermReg.ini from the system"
if (Test-Path "C:\ProgramData\Oracle\Opera\TermReg.ini") {
    Remove-Item -Path "C:\ProgramData\Oracle\Opera\TermReg.ini" -Force
}

$Users = Get-ChildItem -Path "C:\Users" -Directory
foreach ($User in $Users) {
    $userTermRegPath = "C:\Users\$($User.Name)\AppData\Local\TermReg.ini"
    if (Test-Path $userTermRegPath) {
        Remove-Item -Path $userTermRegPath -Force
    }
}

Write-Output "Creating Master TermReg file"
$operaDir = "C:\ProgramData\Oracle\Opera"
if (!(Test-Path $operaDir)) {
    New-Item -ItemType Directory -Path $operaDir
}
$masterTermRegPath = "$operaDir\TermReg.Master"
Set-Content -Path $masterTermRegPath -Value "[OperaTerminal]`nOPERA_TERMINAL=$($ENV:ComputerName)|LargeFont`nUseIni=1"

Write-Output "Replace All User TermReg.ini"
if (Test-Path "C:\Program Files (x86)\Micros Systems, Inc\Opera") {
    Copy-Item -Path $masterTermRegPath -Destination "C:\Program Files (x86)\Micros Systems, Inc\Opera\TermReg.ini" -Force
}

Write-Output "Operation completed."
