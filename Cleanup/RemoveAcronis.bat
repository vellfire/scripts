if not exist C:\Temp md mkdir C:\Temp
curl -o C:\Temp\acroniscleanuptool.exe https://dl.acronis.com/u/KB/Cleanup_Tool_36170_x64/cleanup_tool.exe
C:\Temp\acroniscleanuptool.exe --quiet
del C:\Temp\acroniscleanuptool.exe