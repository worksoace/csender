@REM This script initializes a Git repository, commits changes, and pushes to GitHub.
REM It handles both new repositories and existing ones, with options for merging or force pushing.  

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

    echo.
    echo === Pushing to GitHub... ===
    git push -u origin main 2>git_error.log

    findstr /C:"fetch first" git_error.log >nul
    if %errorlevel%==0 (
        echo.
        echo !!! GitHub repo already has files. Choose an option:
        echo [1] Merge with remote (pull first)
        echo [2] Overwrite remote with local files (force push)
        set /p choice=Enter choice (1 merge or 2 Overwrite): 

        if "!choice!"=="1" (
            git pull origin main --allow-unrelated-histories
            git push origin main
        ) else (
            git push origin main --force
        )
    )

    del git_error.log
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

echo.
echo === Pushing changes... ===
git push origin main 2>git_error.log

findstr /C:"fetch first" git_error.log >nul
if %errorlevel%==0 (
    echo.
    echo !!! GitHub repo has updates you don't have. Choose an option:
    echo [1] Merge with remote (pull first)
    echo [2] Overwrite remote with local files (force push)
    set /p choice=Enter choice (1 or 2): 

    if "!choice!"=="1" (
        git pull origin main --allow-unrelated-histories
        git push origin main
    ) else (
        git push origin main --force
    )
)

del git_error.log
echo.
echo === Push Complete! ===
pause
