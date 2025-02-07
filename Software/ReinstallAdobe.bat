@echo Off
echo Killing Adobe
taskkill /f /im Acrobat*
echo Uninstalling Adobe Reader...
wmic product where "name like 'Adobe Acrobat%%'" call uninstall /nointeractive
wmic product where "name like 'Adobe Reader%%'" call uninstall /nointeractive
echo Uninstalled Adobe Reader
echo Downloading Adobe Reader 2020...
mkdir C:\Temp
curl.exe -o C:\Temp\AcroRdr20202000130002_MUI.exe https://ardownload2.adobe.com/pub/adobe/reader/win/Acrobat2020/2000130002/AcroRdr20202000130002_MUI.exe
echo Downloaded. Installing... This may take a while.
echo This script will quit once complete. Please restart Edge when it's done.
start /wait C:\Temp\AcroRdr20202000130002_MUI.exe /sAll /rs /l /msi /qn /norestart ALLUSERS=1 EULA_ACCEPT=YES SUPPRESS_APP_LAUNCH=YES
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" /v "bProtectedMode" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Adobe\Acrobat Reader\2020\FeatureLockDown" /v "bProtectedMode" /t REG_DWORD /d 0 /f