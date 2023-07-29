@echo off

REM Set the URL of the PowerShell script on GitHub
set "ScriptURL=https://raw.githubusercontent.com/berkantdu123/Remove-MCLEAKS/main/reversehosts.ps1"

REM Set the local path where the script will be downloaded and executed
set "LocalScriptPath=%temp%\reversehosts.ps1"

REM Download the script from GitHub
PowerShell.exe -Command "Invoke-WebRequest -Uri '%ScriptURL%' -OutFile '%LocalScriptPath%'"

REM Execute the downloaded script
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%LocalScriptPath%"

REM Optional: Delete the downloaded script after execution
REM del "%LocalScriptPath%"
pause