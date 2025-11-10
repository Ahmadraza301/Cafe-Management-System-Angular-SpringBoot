# Troubleshooting Guide - Cafe Management System

## Quick Start (After Setup)

1. **Setup Database (First Time Only):**
   ```powershell
   .\setup-database.ps1
   ```

2. **Start the Project:**
   ```powershell
   .\start-project.ps1
   ```

3. **Access Application:**
   - Frontend: http://localhost:4200
   - Backend API: http://localhost:8082

---

## Common Errors and Solutions

### 1. MySQL Errors

#### Error: "Access denied for user 'root'@'localhost'"
**Solution:**
- You have a MySQL password set
- Update `Backend/src/main/resources/application.properties`:
  ```properties
  spring.datasource.password=YOUR_MYSQL_PASSWORD
  ```

#### Error: "Unknown database 'cafe'"
**Solution:**
- Run the database setup script:
  ```powershell
  .\setup-database.ps1
  ```
- Or manually create database:
  ```sql
  CREATE DATABASE cafe;
  USE cafe;
  SOURCE Database.sql;
  ```

#### Error: "Can't connect to MySQL server"
**Solution:**
- Start MySQL service:
  ```cmd
  net start MySQL80
  ```
- Or start from Services (Win + R → services.msc)

---

### 2. Backend (Spring Boot) Errors

#### Error: "Port 8082 already in use"
**Solution Option 1:** Kill the process
```powershell
netstat -ano | findstr :8082
taskkill /PID <PID_NUMBER> /F
```

**Solution Option 2:** Change port in `application.properties`
```properties
server.port=8083
```

#### Error: "Failed to configure a DataSource"
**Solution:**
- Ensure MySQL is running
- Check database credentials in `application.properties`
- Verify database 'cafe' exists

#### Error: Java version mismatch
**Solution:**
- Already fixed! Updated pom.xml to use Java 21
- Or install Java 17 from: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

---

### 3. Frontend (Angular) Errors

#### Error: "digital envelope routines::unsupported"
**Solution:**
```powershell
$env:NODE_OPTIONS = "--openssl-legacy-provider"
ng serve
```

#### Error: "Port 4200 already in use"
**Solution:**
```cmd
ng serve --port 4201
```

#### Error: "Cannot find module '@angular/core'"
**Solution:**
```cmd
cd Frontend
rm -r node_modules
rm package-lock.json
npm install
```

#### Error: "ng: command not found"
**Solution:**
```cmd
npm install -g @angular/cli@12.2.18
```

---

### 4. CORS Errors

#### Error: "Access to XMLHttpRequest blocked by CORS policy"
**Solution:**
- Ensure Backend is running on port 8082
- Check Frontend is calling correct API URL
- Verify CORS configuration in Backend

---

### 5. Login/Authentication Errors

#### Error: "Invalid credentials"
**Solution:**
- Use default credentials:
  - Admin: `bahri.adem25@gmail.com` / `jamila25`
  - User: `adem.bahri@enis.tn` / `123`
- Or sign up a new account

#### Error: "Token expired"
**Solution:**
- Clear browser cache and cookies
- Login again

---

## Manual Start (If Scripts Don't Work)

### Start Backend:
```cmd
cd Backend
mvnw clean install
mvnw spring-boot:run
```

### Start Frontend:
```powershell
cd Frontend
$env:NODE_OPTIONS = "--openssl-legacy-provider"
npm start
```

---

## Verification Checklist

- [ ] MySQL 8.0+ installed and running
- [ ] Database 'cafe' created and schema imported
- [ ] Java 17 or 21 installed
- [ ] Maven installed
- [ ] Node.js installed
- [ ] Frontend dependencies installed (`npm install`)
- [ ] Backend running on port 8082
- [ ] Frontend running on port 4200
- [ ] Can access http://localhost:4200
- [ ] Can login with default credentials

---

## Still Having Issues?

### Check Backend Logs:
- Look at the console where Backend is running
- Common issues: Database connection, port conflicts

### Check Frontend Logs:
- Open browser console (F12)
- Look for API call errors
- Check Network tab for failed requests

### Check MySQL:
```cmd
mysql -u root -p
SHOW DATABASES;
USE cafe;
SHOW TABLES;
```

---

## Performance Issues

### Backend slow to start:
- First run takes longer (Maven downloads dependencies)
- Subsequent runs are faster

### Frontend slow to compile:
- Normal for Angular 12
- Use `ng serve --prod` for production build (faster runtime)

---

## Security Notes

1. **Change default passwords** before deploying to production
2. **Update email credentials** in `application.properties` for email features
3. **Never commit passwords** to version control
4. **Use environment variables** for sensitive data in production

---

## Need More Help?

1. Check the main README.md
2. Check SETUP_GUIDE.md
3. Review application logs
4. Check GitHub issues for similar problems
