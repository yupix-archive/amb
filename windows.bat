@echo off
powershell if(where wsl){Write-Host "found 'wsl'" && Write-Host "お使いのwslで動作可能です。"}Else{Write-Host "not found 'wsl'"}
