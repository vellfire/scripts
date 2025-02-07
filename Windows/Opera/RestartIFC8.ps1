Get-Service | Where-Object {($_.Name -like "*IFC*") -or ($_.Name -like "*OPI*") -or ($_.Name -like "*FLIP*")} | Restart-Service
