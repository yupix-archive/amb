@echo off
powershell if(where wsl){wsl .\linux.sh}Else{Write-Host "not found 'wsl'"}
