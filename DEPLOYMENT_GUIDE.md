# 🚀 Deployment Guide - Cafe Management System

## Overview

Your application has 3 components that need hosting:
1. **Frontend** (Angular) - Static files
2. **Backend** (Spring Boot) - Java application
3. **Database** (MySQL) - Database server

---

## 🎯 Best Hosting Options

### **Option 1: Free Hosting (Recommended for Testing)**

#### **Frontend: Vercel or Netlify (FREE)**
#### **Backend: Render.com (FREE)**
#### **Database: Railway.app or Clever Cloud (FREE)**

### **Option 2: All-in-One (Easiest)**

#### **Heroku** - Host everything in one place
- Frontend + Backend + Database
- $7-13/month (has free tier with limitations)

### **Option 3: Professional (Best Performance)**

#### **AWS, Google Cloud, or DigitalOcean**
- Full control
- $10-50/month depending on usage

---

## 📋 Detailed Deployment Steps

---

## 🟢 **OPTION 1: FREE HOSTING (RECOMMENDED)**

### **Step 1: Deploy Database (Railway.app - FREE)**

1. **Go to:** https://railway.app/
2. **Sign up** with GitHub
3. Click **"New Project"**
4. Select **"Provision MySQL"**
5. **Copy the connection details:**
   - Host
   - Port
   - Username
   - Password
   - Database name

6. **Import your database:**
   ```bash
   mysql -h [HOST] -P [PORT] -u [USERNAME] -p[PASSWORD] [DATABASE] < Database.sql
   ```

---

### **Step 2: Deploy Backend (Render.com - FREE)**

1. **Go to:** https://render.com/
2. **Sign up** with GitHub
3. Click **"New +"** → **"Web Service"**
4. Connect your GitHub repository
5. **Configure:**
   - **Name:** cafe-backend
   - **Environment:** Java
   - **Build Command:** `cd Backend && ./mvnw clean package -DskipTests`
   - **Start Command:** `cd Backend && java -jar target/*.jar`
   - **Instance Type:** Free

6. **Add Environment Variables:**
   ```
   SPRING_DATASOURCE_URL=jdbc:mysql://[RAILWAY_HOST]:[PORT]/[DATABASE]
   SPRING_DATASOURCE_USERNAME=[RAILWAY_USERNAME]
   SPRING_DATASOURCE_PASSWORD=[RAILWAY_PASSWORD]
   SERVER_PORT=8080
   ```

7. Click **"Create Web Service"**
8. **Copy your backend URL:** `https://cafe-backend.onrender.com`

---

### **Step 3: Deploy Frontend (Vercel - FREE)**

1. **Update API URL in Frontend:**
   
   Edit: `Frontend/src/environments/environment.prod.ts`
   ```typescript
   export const environment = {
     production: true,
     apiUrl: 'https://cafe-backend.onrender.com'
   };
   ```

2. **Build Frontend:**
   ```bash
   cd Frontend
   npm run build -- --configuration production
   ```

3. **Go to:** https://vercel.com/
4. **Sign up** with GitHub
5. Click **"Add New Project"**
6. Import your GitHub repository
7. **Configure:**
   - **Framework Preset:** Angular
   - **Root Directory:** Frontend
   - **Build Command:** `npm run build -- --configuration production`
   - **Output Directory:** `dist/frontend`

8. Click **"Deploy"**
9. **Your app is live!** `https://your-app.vercel.app`

---

## 🔵 **OPTION 2: HEROKU (ALL-IN-ONE)**

### **Prerequisites:**
- Install Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli

### **Step 1: Prepare Your Project**

1. **Create Procfile in root:**
   ```
   web: cd Backend && java -jar target/*.jar
   ```

2. **Create system.properties in Backend folder:**
   ```
   java.runtime.version=17
   ```

### **Step 2: Deploy to Heroku**

```bash
# Login to Heroku
heroku login

# Create app
heroku create cafe-management-system

# Add MySQL addon
heroku addons:create jawsdb:kitefin

# Get database credentials
heroku config:get JAWSDB_URL

# Update application.properties with Heroku database URL

# Deploy
git push heroku main

# Import database
heroku run bash
mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] < Database.sql
```

### **Step 3: Deploy Frontend**

Build and deploy frontend separately to Vercel (see Option 1, Step 3)

---

## 🟣 **OPTION 3: DIGITALOCEAN (PROFESSIONAL)**

### **Cost:** ~$12/month (Droplet + Database)

1. **Create Droplet** (Ubuntu 22.04)
2. **Install Java 17, MySQL, Nginx**
3. **Deploy Backend** as systemd service
4. **Deploy Frontend** to Nginx
5. **Configure SSL** with Let's Encrypt

**Detailed guide:** https://www.digitalocean.com/community/tutorials

---

## 🎯 **RECOMMENDED: Quick Start (FREE)**

### **For Testing/Portfolio:**

1. **Database:** Railway.app (FREE)
2. **Backend:** Render.com (FREE)
3. **Frontend:** Vercel (FREE)

**Total Cost:** $0/month
**Setup Time:** 30-60 minutes

### **For Production:**

1. **Database:** AWS RDS or DigitalOcean Managed Database
2. **Backend:** AWS EC2 or DigitalOcean Droplet
3. **Frontend:** Vercel or Netlify (FREE)

**Total Cost:** $15-30/month
**Setup Time:** 2-4 hours

---

## 📝 **Important Configuration Changes**

### **1. Update CORS in Backend**

Edit: `Backend/src/main/java/com/inn/cafe/JWT/SecurityConfig.java`

Add your frontend URL to allowed origins:
```java
@Bean
public CorsFilter corsFilter() {
    CorsConfiguration config = new CorsConfiguration();
    config.addAllowedOrigin("https://your-frontend.vercel.app");
    config.addAllowedOrigin("http://localhost:4200"); // for local testing
    // ... rest of config
}
```

### **2. Update Frontend API URL**

Edit: `Frontend/src/environments/environment.prod.ts`
```typescript
export const environment = {
  production: true,
  apiUrl: 'https://your-backend.onrender.com'
};
```

### **3. Database Connection**

Update `application.properties` with production database credentials.

---

## 🔒 **Security Checklist**

Before going live:

- [ ] Change all default passwords
- [ ] Use environment variables for sensitive data
- [ ] Enable HTTPS/SSL
- [ ] Configure CORS properly
- [ ] Set up database backups
- [ ] Enable rate limiting
- [ ] Update JWT secret key
- [ ] Remove debug/test endpoints

---

## 🚀 **Quick Deploy Script**

I can create automated deployment scripts for you. Which option do you prefer?

1. **Free (Railway + Render + Vercel)**
2. **Heroku (All-in-one)**
3. **DigitalOcean (Professional)**

Let me know and I'll create the deployment scripts!

---

## 📞 **Need Help?**

Common issues:
- **CORS errors:** Update SecurityConfig.java
- **Database connection:** Check credentials and firewall
- **Build fails:** Ensure Java 17 and Node.js versions match
- **Port issues:** Use environment variable PORT

---

## 🎉 **After Deployment**

Your app will be live at:
- **Frontend:** https://your-app.vercel.app
- **Backend API:** https://your-backend.onrender.com
- **Admin Login:** Use your credentials

**Share your live URL with the world!** 🌍
