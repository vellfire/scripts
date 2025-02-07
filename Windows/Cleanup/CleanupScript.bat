@echo off

echo Running full disk cleanup...
cleanmgr /sageset:1
cleanmgr /sagerun:1

echo Optimizing disk...
defrag /C /M /B /L /O

echo Cleaning up update files...
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

echo Clearing DNS Cache...
ipconfig /flushdns

echo Cleaning up temporary directories...
rd /s /q %TEMP%
md %TEMP%

echo Cleanup script completed.
