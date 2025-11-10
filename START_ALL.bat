@echo off
echo ========================================
echo   Cafe Management System - Starting
echo ========================================
echo.

echo [1/2] Starting Backend Server...
start "Backend Server" cmd /k "cd Backend && mvnw.cmd spring-boot:run"

echo [2/2] Waiting 15 seconds for Backend to start...
timeout /t 15 /nobreak

echo [2/2] Starting Frontend Server...
start "Frontend Server" cmd /k "cd Frontend && set NODE_OPTIONS=--openssl-legacy-provider && npm start"

echo.
echo ========================================
echo   Both servers are starting!
echo ========================================
echo.
echo Backend:  http://localhost:8082
echo Frontend: http://localhost:4200
echo.
echo Login: bahri.adem25@gmail.com / jamila25
echo.
pause
