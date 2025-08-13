@echo off
setlocal EnableDelayedExpansion

REM === Change to your project folder ===
cd /d "C:\Users\Emmanuel Chijioke\Documents\csender"

REM === Check if this is already a git repo ===
if not exist ".git" (
    echo === No Git repository found. Setting up Git... ===
    git init
    git branch -M main

    set "repoLink="
    set /p "repoLink=Enter your GitHub repository link (e.g. https://github.com/USERNAME/REPO-NAME.git): "
    git remote add origin "!repoLink!"

    echo.
    echo === Adding all files for the first commit ===
    git add .
    set "firstMsg="
    set /p "firstMsg=Enter commit message for first push: "
    git commit -m "!firstMsg!"
    git push -u origin main

    echo.
    echo === Repository initialized and pushed successfully! ===
    pause
    exit /b
)

REM === If repo exists, normal push ===
echo.
echo === Checking Git Status ===
git status

set "msg="
set /p "msg=Enter commit message: "
git add .
git commit -m "!msg!"
git push origin main

echo.
echo === Push Complete! ===
pause
