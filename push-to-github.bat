@echo off
echo ========================================
echo   Push to GitHub
echo ========================================
echo.

echo Step 1: Setting up remote repository...
git remote add origin https://github.com/Ahmadraza301/Cafe-Management-System.git

echo.
echo Step 2: Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo   Done!
echo ========================================
echo.
echo Your code is now on GitHub at:
echo https://github.com/Ahmadraza301/Cafe-Management-System
echo.
pause
