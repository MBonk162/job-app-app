# Deploying to Vercel

This guide walks you through deploying the Job Application Tracker to Vercel.

## Prerequisites

1. A [Vercel account](https://vercel.com/signup)
2. [Vercel CLI](https://vercel.com/cli) installed (optional, but recommended)
   ```bash
   npm install -g vercel
   ```

## Deployment Steps

### Option 1: Deploy via Vercel Dashboard (Recommended for first-time)

1. **Push your code to GitHub/GitLab/Bitbucket**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

2. **Import project in Vercel**
   - Go to [Vercel Dashboard](https://vercel.com/dashboard)
   - Click "Add New..." → "Project"
   - Import your repository
   - Vercel will auto-detect the configuration from `vercel.json`

3. **Configure Environment Variables** (in Vercel Dashboard)
   - Go to your project settings
   - Navigate to "Environment Variables"
   - Add the following variables:

     **Server Variables:**
     - `PORT` = `5000`
     - `GOOGLE_CLIENT_ID` = your Google OAuth client ID (when ready)
     - `GOOGLE_CLIENT_SECRET` = your Google OAuth secret (when ready)
     - `GOOGLE_SHEET_ID` = your Google Sheet ID (when ready)
     - `GOOGLE_REDIRECT_URI` = `https://your-domain.vercel.app/auth/callback`
     - `EMAIL_SERVICE` = `gmail` (if using email features)
     - `EMAIL_USER` = your email
     - `EMAIL_PASSWORD` = your app password
     - `TRELLO_EMAIL` = your Trello board email (if using)

     **Client Variables:**
     - `VITE_API_URL` = `/api` (this tells the frontend to use relative URLs)

4. **Deploy**
   - Click "Deploy"
   - Vercel will build and deploy your application
   - You'll get a URL like `https://your-project.vercel.app`

### Option 2: Deploy via Vercel CLI

1. **Login to Vercel**
   ```bash
   vercel login
   ```

2. **Deploy from the project root**
   ```bash
   cd job_app_app
   vercel
   ```

3. **Follow the prompts**
   - Link to existing project or create new one
   - Confirm the settings

4. **Set environment variables**
   ```bash
   vercel env add GOOGLE_CLIENT_ID
   vercel env add GOOGLE_CLIENT_SECRET
   vercel env add GOOGLE_SHEET_ID
   # ... add other variables as needed
   ```

5. **Deploy to production**
   ```bash
   vercel --prod
   ```

## Project Structure for Vercel

```
job_app_app/
├── api/
│   └── index.js           # Serverless API entry point
├── client/
│   ├── src/              # React application source
│   ├── dist/             # Build output (generated)
│   └── package.json
├── server/
│   └── src/              # Server logic (used by api/index.js)
├── vercel.json           # Vercel configuration
└── DEPLOYMENT.md         # This file
```

## How It Works

1. **Frontend (React/Vite)**
   - Built as a static site from `client/`
   - Output to `client/dist/`
   - Served as the main application

2. **Backend (Node.js/Express)**
   - Server code converted to Vercel serverless functions
   - Entry point: `api/index.js`
   - Routes under `/api/*` are handled by the serverless function

3. **API Routing**
   - Frontend makes requests to `/api/*`
   - Vercel routes these to the serverless function
   - Same domain = no CORS issues

## Verifying Your Deployment

After deployment, test the following:

1. **Health Check**
   ```bash
   curl https://your-project.vercel.app/api/health
   ```
   Should return: `{"status":"OK","message":"Job Tracker API is running"}`

2. **Frontend**
   - Visit `https://your-project.vercel.app`
   - You should see the job tracker dashboard

3. **API Endpoints**
   - Check that the applications list loads
   - Try adding a new application

## Continuous Deployment

Once connected to Git:
- Every push to `main` branch triggers a production deployment
- Pull requests get preview deployments
- Vercel provides unique URLs for each deployment

## Troubleshooting

### Build Failures

1. **Check build logs** in Vercel Dashboard
2. **Verify package.json scripts** are correct
3. **Ensure all dependencies** are in `dependencies` (not `devDependencies`) if needed at runtime

### API Not Working

1. **Check environment variables** are set correctly
2. **Verify API routes** in `api/index.js`
3. **Check serverless function logs** in Vercel Dashboard

### 404 Errors

1. **Ensure rewrites** in `vercel.json` are correct
2. **Check that `/api` prefix** matches in both client and server

## Custom Domain

1. Go to your project in Vercel Dashboard
2. Navigate to "Settings" → "Domains"
3. Add your custom domain
4. Update DNS records as instructed
5. Update `GOOGLE_REDIRECT_URI` if using OAuth

## Local Development

For local development, continue using:
```bash
# Terminal 1 - Server
cd server
npm run dev

# Terminal 2 - Client
cd client
npm run dev
```

The Vite dev server proxy handles routing `/api` to `http://localhost:5000` during development.

## Notes

- Current deployment uses **mock data**
- Google Sheets integration requires OAuth setup (see main README.md)
- Environment variables must be set in Vercel Dashboard for production
- Serverless functions have a 10-second timeout (configurable in `vercel.json`)
