@echo off
echo Starting Frontend Server...
cd Frontend
set NODE_OPTIONS=--openssl-legacy-provider
call npm start
pause
