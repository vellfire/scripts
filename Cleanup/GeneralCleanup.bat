@ECHO OFF
CLS
ECHO.
ECHO Cleaning Windows Search...
net stop "Windows Search"
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
DEL /F /Q "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
net start "Windows Search"

ECHO.
ECHO Cleaning CBS logs...
net stop TrustedInstaller
DEL /F /S /Q "C:\Windows\Logs\CBS\*"
RMDIR /S /Q "C:\Windows\Logs\CBS"
TIMEOUT /T 3 /NOBREAK
net start TrustedInstaller

REM Disabling Hibernation...
powercfg /h off

ECHO.
ECHO Running Disk Cleanup...
FOR %%V IN (
    "Active Setup Temp Folders",
    "Content Indexer Cleaner",
    "Downloaded Program Files",
    "Internet Cache Files",
    "Memory Dump Files",
    "Microsoft_Event_Reporting_2.0_Temp_Files",
    "Offline Pages Files",
    "Old ChkDsk Files",
    "Previous Installations",
    "Recycle Bin",
    "Remote Desktop Cache Files",
    "ServicePack Cleanup",
    "Setup Log Files",
    "System error memory dump files",
    "System error minidump files",
    "Temporary Files",
    "Temporary Setup Files",
    "Temporary Sync Files",
    "Update Cleanup",
    "Upgrade Discarded Files",
    "WebClient and WebPublisher Cache",
    "Windows Defender",
    "Windows Error Reporting Archive Files",
    "Windows Error Reporting Queue Files",
    "Windows Error Reporting System Archive Files",
    "Windows Error Reporting System Queue Files",
    "Windows ESD installation files",
    "Windows Upgrade Log Files"
) DO (
    REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\%%V" /v StateFlags0090 /t REG_DWORD /d 2 /f
)
START cleanmgr /sagerun:90

IF EXIST "C:\Users\" (
    FOR /D %%x IN ("C:\Users\*") DO (
        DEL /F /S /Q "%%x\AppData\Local\Temp\*"
        DEL /F /S /Q "%%x\AppData\Local\Microsoft\Windows\Temporary Internet Files\*"
        DEL /F /S /Q "%%x\AppData\Roaming\Microsoft\Teams\Service Worker\CacheStorage\*"
        DEL /F /S /Q "%%x\AppData\Local\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage\*"
        DEL /F /S /Q "%%x\AppData\Local\Microsoft\Windows\WER\*"
    )
)

DEL /F /S /Q "C:\Windows\Temp\*"

ECHO System integrity
%SystemRoot%\System32\sfc.exe /scannow
IF NOT %ERRORLEVEL%==0 (
  REM Dism /Online /Cleanup-Image /RestoreHealth
) ELSE (
  ECHO OK
)

ECHO Cleanup complete.
PAUSE
