# Cafe Management System - Complete Setup Guide

## Prerequisites Installation

### 1. Install MySQL 8.0+
**Download:** https://dev.mysql.com/downloads/mysql/
- Choose "MySQL Installer for Windows"
- During installation:
  - Select "Developer Default" or "Server only"
  - Set root password (leave empty if you want to match application.properties)
  - Remember the port (default: 3306)

**Verify Installation:**
```cmd
mysql --version
```

### 2. Java Version (Optional Fix)
Your system has Java 21, but the project specifies Java 17. This should work, but if you encounter issues:
- Download Java 17: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
- Or update `Backend/pom.xml` to use Java 21

## Database Setup

### Step 1: Start MySQL Service
```cmd
net start MySQL80
```

### Step 2: Create Database
```cmd
mysql -u root -p
```
(Press Enter if no password, or enter your MySQL root password)

Then run:
```sql
CREATE DATABASE cafe;
USE cafe;
SOURCE Database.sql;
EXIT;
```

**Alternative:** Use MySQL Workbench or phpMyAdmin to import `Database.sql`

## Backend Setup (Spring Boot)

### Step 1: Navigate to Backend folder
```cmd
cd Backend
```

### Step 2: Update Database Configuration (if needed)
Edit `Backend/src/main/resources/application.properties`:
- Update `spring.datasource.password` if you set a MySQL password
- Update email configuration if you want email features to work

### Step 3: Build and Run
```cmd
mvnw clean install
mvnw spring-boot:run
```

**Verify:** Backend should run on http://localhost:8082

## Frontend Setup (Angular)

### Step 1: Navigate to Frontend folder
```cmd
cd Frontend
```

### Step 2: Install Dependencies
```cmd
npm install
```

### Step 3: Fix Node.js OpenSSL Issue (for Angular 12)
```powershell
$env:NODE_OPTIONS = "--openssl-legacy-provider"
```

### Step 4: Start Development Server
```cmd
npm start
```
or
```cmd
ng serve
```

**Verify:** Frontend should run on http://localhost:4200

## Common Errors and Solutions

### Error: "MySQL not found"
- Install MySQL from the link above
- Add MySQL to PATH: `C:\Program Files\MySQL\MySQL Server 8.0\bin`

### Error: "Port 8082 already in use"
- Change port in `Backend/src/main/resources/application.properties`
- Or kill the process using port 8082

### Error: "Port 4200 already in use"
- Run: `ng serve --port 4201`

### Error: "Cannot find module" (Frontend)
- Delete `node_modules` and `package-lock.json`
- Run `npm install` again

### Error: "digital envelope routines::unsupported" (Frontend)
- Run: `$env:NODE_OPTIONS = "--openssl-legacy-provider"`
- This is required for Angular 12 with Node.js 17+

### Error: Java version mismatch
- Either install Java 17 or update `pom.xml` to use Java 21

## Default Login Credentials

From the database, you can use:
- **Admin:** bahri.adem25@gmail.com / jamila25
- **User:** adem.bahri@enis.tn / 123

## Testing the Application

1. Open browser: http://localhost:4200
2. Sign up or login with credentials above
3. Admin users can access all features
4. Regular users have limited access

## Project Structure

```
├── Backend/          # Spring Boot REST API (Port 8082)
├── Frontend/         # Angular Application (Port 4200)
└── Database.sql      # MySQL Database Schema
```

## Next Steps

1. Install MySQL if not already installed
2. Create and import the database
3. Start the Backend server
4. Start the Frontend server
5. Access the application at http://localhost:4200
