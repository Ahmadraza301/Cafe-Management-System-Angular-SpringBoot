# Database Setup Script for Cafe Management System

Write-Host "=== Database Setup for Cafe Management System ===" -ForegroundColor Cyan
Write-Host ""

$mysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

if (-not (Test-Path $mysqlPath)) {
    Write-Host "✗ MySQL not found at: $mysqlPath" -ForegroundColor Red
    Write-Host "Please install MySQL 8.0+ from: https://dev.mysql.com/downloads/mysql/" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ MySQL found" -ForegroundColor Green
Write-Host ""

# Get MySQL password
Write-Host "Enter your MySQL root password (press Enter if no password):" -ForegroundColor Yellow
$password = Read-Host -AsSecureString
$passwordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

Write-Host ""
Write-Host "Creating database and importing schema..." -ForegroundColor Yellow

# Create database
if ($passwordPlain -eq "") {
    & $mysqlPath -u root -e "CREATE DATABASE IF NOT EXISTS cafe;"
    Write-Host "✓ Database 'cafe' created" -ForegroundColor Green
    
    # Import schema
    Write-Host "Importing database schema..." -ForegroundColor Yellow
    & $mysqlPath -u root cafe < Database.sql
    Write-Host "✓ Database schema imported successfully" -ForegroundColor Green
} else {
    & $mysqlPath -u root -p"$passwordPlain" -e "CREATE DATABASE IF NOT EXISTS cafe;"
    Write-Host "✓ Database 'cafe' created" -ForegroundColor Green
    
    # Import schema
    Write-Host "Importing database schema..." -ForegroundColor Yellow
    & $mysqlPath -u root -p"$passwordPlain" cafe < Database.sql
    Write-Host "✓ Database schema imported successfully" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Database Setup Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Default users created:" -ForegroundColor Yellow
Write-Host "Admin: bahri.adem25@gmail.com / jamila25" -ForegroundColor White
Write-Host "User: adem.bahri@enis.tn / 123" -ForegroundColor White
Write-Host ""

# Update application.properties if password was set
if ($passwordPlain -ne "") {
    Write-Host "IMPORTANT: Update Backend/src/main/resources/application.properties" -ForegroundColor Yellow
    Write-Host "Set: spring.datasource.password=$passwordPlain" -ForegroundColor White
    Write-Host ""
}

Write-Host "You can now run the project using: .\start-project.ps1" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
