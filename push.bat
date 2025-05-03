@echo off
echo Committing and pushing to 'update' branch...

:: Replace with your info
set GIT_URL=http://github.com/Twaddler01/bible_driller_app.git

:: Initialize Git if not already done
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not a git repository. Run this in your repo folder.
    pause
    exit /b
)

:: Create 'update' branch if it doesn't exist
git rev-parse --verify update >nul 2>&1
if errorlevel 1 (
    echo 'update' branch does not exist. Creating it now...
    git checkout -b update
) else (
    git checkout update
)

:: Add, commit, and push changes
git add .
git commit -m "Update from push.bat"
git push %GIT_URL% update

echo Push complete.
pause
