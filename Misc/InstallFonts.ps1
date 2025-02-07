$fontSource = "https://example.com/fonts.zip"
$fontDest = "C:\Temp\Fonts.zip"
$fontDir = "C:\Temp\Fonts"

# Download and extract fonts
if(!(Test-Path -PathType container "C:\Temp\Fonts")){New-Item -ItemType Directory -Path "C:\Temp\Fonts"}
curl.exe -k $fontSource -o $fontDest
Expand-Archive -Path $fontDest -DestinationPath $fontDir


# Install fonts
Get-ChildItem -Path "$fontDir\*" -Include '*.fon', '*.otf', '*.ttc', '*.ttf' | ForEach-Object {
        Write-Host "Installing font -" $_.BaseName
        Copy-Item -Path $_.FullName -Destination "C:\Windows\Fonts" -Force
        New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $_.BaseName -PropertyType String -Value $_.Name -Force
}

# Cleanup
Remove-Item -Path $fontDir, $fontDest -Recurse -Force
