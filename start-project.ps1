# Cafe Management System - Quick Start Script
# Run this script to start both Backend and Frontend

Write-Host "=== Cafe Management System - Quick Start ===" -ForegroundColor Cyan
Write-Host ""

# Check MySQL
Write-Host "Checking MySQL..." -ForegroundColor Yellow
$mysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
if (Test-Path $mysqlPath) {
    Write-Host "✓ MySQL found" -ForegroundColor Green
} else {
    Write-Host "✗ MySQL not found. Please install MySQL 8.0+" -ForegroundColor Red
    Write-Host "Download from: https://dev.mysql.com/downloads/mysql/" -ForegroundColor Yellow
    exit 1
}

# Check if database exists
Write-Host ""
Write-Host "Checking database..." -ForegroundColor Yellow
Write-Host "NOTE: If you haven't created the 'cafe' database yet, please:" -ForegroundColor Yellow
Write-Host "1. Open MySQL Workbench or command line" -ForegroundColor Yellow
Write-Host "2. Run: CREATE DATABASE cafe;" -ForegroundColor Yellow
Write-Host "3. Import Database.sql file" -ForegroundColor Yellow
Write-Host ""

# Start Backend
Write-Host "Starting Backend (Spring Boot)..." -ForegroundColor Yellow
Write-Host "Backend will run on: http://localhost:8082" -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd Backend; .\mvnw spring-boot:run"

# Wait a bit for backend to start
Write-Host "Waiting 10 seconds for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Start Frontend
Write-Host ""
Write-Host "Starting Frontend (Angular)..." -ForegroundColor Yellow
Write-Host "Frontend will run on: http://localhost:4200" -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd Frontend; `$env:NODE_OPTIONS='--openssl-legacy-provider'; npm start"

Write-Host ""
Write-Host "=== Both servers are starting ===" -ForegroundColor Green
Write-Host "Backend: http://localhost:8082" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:4200" -ForegroundColor Cyan
Write-Host ""
Write-Host "Default Admin Login:" -ForegroundColor Yellow
Write-Host "Email: bahri.adem25@gmail.com" -ForegroundColor White
Write-Host "Password: jamila25" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to exit this window (servers will continue running)..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
