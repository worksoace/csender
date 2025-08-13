@echo off
REM Smart Git Push Script
REM Detects changes, commits them, pulls remote changes, and pushes to main branch.

cd /d "C:\Users\Emmanuel Chijioke\Documents\csender"

echo.
echo === Checking Git Status ===
git status

REM Check for any changes
set "changed="
for /f "tokens=*" %%i in ('git status --porcelain') do (
    set changed=true
)

REM Exit if nothing to commit
if not defined changed (
    echo No changes to commit. Exiting...
    timeout /t 2 >nul
    exit /b
)

echo.
echo === Staging Files ===
git add .

echo.
set /p "msg=Enter your commit message: "
git commit -m "%msg%"

echo.
echo === Pulling from origin/main ===
git pull origin main --no-edit

echo.
echo === Pushing to origin/main ===
git push origin main

echo.
echo === Push Complete! ===
pause
