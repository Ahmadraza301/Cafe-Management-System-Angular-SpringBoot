# 🚀 Vercel + Render Deployment Guide

## Complete Setup to Connect Frontend (Vercel) with Backend (Render)

---

## 📋 What We're Doing

1. **Frontend (Angular)** → Deploy to **Vercel**
2. **Backend (Spring Boot)** → Deploy to **Render**
3. **Database (MySQL)** → Deploy to **Railway** (Free)
4. **Connect them all** through API

---

## ✅ Changes Already Made

I've updated your project with:

1. ✅ **Frontend API Configuration** - `environment.prod.ts` updated
2. ✅ **Backend CORS Settings** - Allows requests from Vercel
3. ✅ **Vercel Configuration** - `vercel.json` created
4. ✅ **Render Configuration** - `render.yaml` created

---

## 🗄️ STEP 1: Deploy Database (Railway)

### **1.1 Create Database**

1. Go to: https://railway.app/
2. Click **"Start a New Project"**
3. Select **"Provision MySQL"**
4. Wait for deployment (1-2 minutes)

### **1.2 Get Database Credentials**

1. Click on your MySQL service
2. Go to **"Variables"** tab
3. **Copy these values:**
   ```
   MYSQL_HOST: [example: containers-us-west-123.railway.app]
   MYSQL_PORT: [example: 6789]
   MYSQL_USER: [example: root]
   MYSQL_PASSWORD: [example: abc123xyz]
   MYSQL_DATABASE: [example: railway]
   ```

### **1.3 Import Your Database**

**Option A: Using Railway Console**
1. Click **"Data"** tab
2. Click **"Query"** button
3. Copy and paste contents of `Database.sql`
4. Click **"Run"**

**Option B: Using MySQL Workbench**
1. Create new connection with Railway credentials
2. Import `Database.sql` file

**Option C: Using Command Line**
```bash
mysql -h [MYSQL_HOST] -P [MYSQL_PORT] -u [MYSQL_USER] -p[MYSQL_PASSWORD] [MYSQL_DATABASE] < Database.sql
```

✅ **Database is ready!**

---

## 🔧 STEP 2: Deploy Backend (Render)

### **2.1 Prepare Backend**

Your backend is already configured! The CORS settings allow Vercel connections.

### **2.2 Deploy to Render**

1. Go to: https://render.com/
2. Click **"New +"** → **"Web Service"**
3. Click **"Connect GitHub"** and authorize
4. Select repository: **`Cafe-Management-System-Angular-SpringBoot`**

### **2.3 Configure Service**

**Basic Settings:**
- **Name:** `cafe-backend` (or your choice)
- **Region:** Choose closest to you
- **Branch:** `main`
- **Root Directory:** `Backend`
- **Runtime:** `Java`

**Build Settings:**
- **Build Command:**
  ```bash
  ./mvnw clean package -DskipTests
  ```
- **Start Command:**
  ```bash
  java -Dserver.port=$PORT -jar target/*.jar
  ```

**Instance Type:**
- Select **"Free"**

### **2.4 Add Environment Variables**

Click **"Advanced"** → **"Add Environment Variable"**

Add these variables (use Railway credentials from Step 1.2):

```
SPRING_DATASOURCE_URL=jdbc:mysql://[MYSQL_HOST]:[MYSQL_PORT]/[MYSQL_DATABASE]?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true

SPRING_DATASOURCE_USERNAME=[MYSQL_USER]

SPRING_DATASOURCE_PASSWORD=[MYSQL_PASSWORD]

SERVER_PORT=8080
```

**Example:**
```
SPRING_DATASOURCE_URL=jdbc:mysql://containers-us-west-123.railway.app:6789/railway?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true

SPRING_DATASOURCE_USERNAME=root

SPRING_DATASOURCE_PASSWORD=abc123xyz

SERVER_PORT=8080
```

### **2.5 Deploy**

1. Click **"Create Web Service"**
2. Wait for build and deployment (5-10 minutes)
3. **Copy your backend URL:** `https://cafe-backend.onrender.com`

✅ **Backend is live!**

---

## 🎨 STEP 3: Update Frontend with Backend URL

### **3.1 Update Environment File**

The file is already updated, but verify:

**File:** `Frontend/src/environments/environment.prod.ts`

```typescript
export const environment = {
  production: true,
  apiUrl: 'https://cafe-backend.onrender.com'  // ← Your Render URL
};
```

**Replace** `cafe-backend.onrender.com` with **your actual Render URL** from Step 2.5

### **3.2 Commit Changes**

```bash
git add .
git commit -m "Configure production API URL for Render backend"
git push origin main
```

---

## 🌐 STEP 4: Deploy Frontend (Vercel)

### **4.1 Deploy to Vercel**

1. Go to: https://vercel.com/
2. Click **"Add New..."** → **"Project"**
3. Click **"Import Git Repository"**
4. Select: **`Cafe-Management-System-Angular-SpringBoot`**

### **4.2 Configure Project**

**Framework Preset:** `Other` (don't select Angular)

**Root Directory:** `Frontend`

**Build Settings:**
- **Build Command:**
  ```bash
  npm install && npm run build -- --configuration production
  ```
- **Output Directory:**
  ```
  dist/frontend
  ```
- **Install Command:**
  ```bash
  npm install
  ```

### **4.3 Deploy**

1. Click **"Deploy"**
2. Wait for deployment (3-5 minutes)
3. **Your app is live!** `https://your-app.vercel.app`

✅ **Frontend is live!**

---

## 🔗 STEP 5: Test the Connection

### **5.1 Test Backend API**

Visit your Render URL in browser:
```
https://cafe-backend.onrender.com/user/checkToken
```

You should see an error (expected - no token), but it means backend is running!

### **5.2 Test Frontend**

1. Open your Vercel URL: `https://your-app.vercel.app`
2. Try to **Sign Up** with a new account
3. Check if you see: "Sign up is pending for admin approval"
4. **Login** with admin credentials:
   - Email: `321ahmad0042@gmail.com`
   - Password: `saq123`

### **5.3 Check Browser Console**

1. Press **F12** to open Developer Tools
2. Go to **"Network"** tab
3. Try to login
4. Check if API calls are going to your Render backend URL

---

## 🎉 SUCCESS! Your App is Live

### **Your URLs:**
- **Frontend:** `https://your-app.vercel.app`
- **Backend:** `https://cafe-backend.onrender.com`
- **Database:** Railway (internal)

### **Login Credentials:**
- **Admin:** 321ahmad0042@gmail.com / saq123
- **Admin:** bahri.adem25@gmail.com / jamila25

---

## ⚠️ Important Notes

### **Free Tier Limitations:**

**Render (Backend):**
- ⏰ Spins down after 15 minutes of inactivity
- 🐌 First request after sleep: 30-60 seconds
- 💰 750 hours/month free

**Railway (Database):**
- 💵 $5 free credit/month (~500 hours)
- 💾 1GB storage
- 🔄 Resets monthly

**Vercel (Frontend):**
- ⚡ Always fast (no sleep)
- 🚀 Unlimited deployments
- 📊 100GB bandwidth/month

### **Keep Backend Awake:**

Use **UptimeRobot** (free):
1. Go to: https://uptimerobot.com/
2. Add monitor: `https://cafe-backend.onrender.com`
3. Check interval: Every 5 minutes
4. Your backend stays awake!

---

## 🔧 Troubleshooting

### **Problem: Frontend can't connect to Backend**

**Solution:**
1. Check CORS is enabled in `SecurityConfig.java` ✅ (Already done)
2. Verify API URL in `environment.prod.ts`
3. Check Render backend is running (visit URL)
4. Check browser console for errors

### **Problem: Backend shows "Database connection failed"**

**Solution:**
1. Verify Railway database is running
2. Check environment variables in Render
3. Test database connection from local machine
4. Ensure `allowPublicKeyRetrieval=true` in connection string

### **Problem: "CORS policy" error**

**Solution:**
Already fixed! But if you see it:
1. Check `SecurityConfig.java` has `addAllowedOrigin("*")`
2. Redeploy backend on Render
3. Clear browser cache

### **Problem: Backend is slow on first request**

**Solution:**
This is normal for Render free tier. Options:
1. Use UptimeRobot to keep it awake
2. Upgrade to Render paid plan ($7/month)
3. Wait 30-60 seconds for first request

---

## 📈 Next Steps

### **Custom Domain:**
1. Go to Vercel project settings
2. Add your custom domain
3. Update DNS records
4. SSL certificate is automatic!

### **Environment Variables:**
Add these in Vercel if needed:
- `API_URL` - Your Render backend URL

### **Monitoring:**
- Set up UptimeRobot for backend
- Enable Vercel Analytics
- Check Render logs regularly

---

## 💰 Upgrade Options

When ready to scale:

**Render:**
- Starter: $7/month (no sleep, better performance)
- Standard: $25/month (more resources)

**Railway:**
- Pay as you go: ~$5-10/month
- More storage and uptime

**Vercel:**
- Pro: $20/month (team features)
- Free tier is usually enough!

---

## ✅ Deployment Checklist

- [ ] Railway database created and imported
- [ ] Render backend deployed with environment variables
- [ ] Frontend `environment.prod.ts` updated with Render URL
- [ ] Changes committed and pushed to GitHub
- [ ] Vercel frontend deployed
- [ ] Tested signup functionality
- [ ] Tested login with admin credentials
- [ ] Tested API connection in browser console
- [ ] Set up UptimeRobot monitoring
- [ ] Shared live URL with friends!

---

## 🎊 Congratulations!

Your Cafe Management System is now live and accessible worldwide!

**Share your app:**
- Frontend: `https://your-app.vercel.app`
- Add it to your portfolio
- Share on LinkedIn
- Show it to potential employers!

---

## 📞 Need Help?

Common issues and solutions are listed in the Troubleshooting section above.

**Quick Links:**
- Vercel Dashboard: https://vercel.com/dashboard
- Render Dashboard: https://dashboard.render.com/
- Railway Dashboard: https://railway.app/dashboard

**Good luck! 🚀**
