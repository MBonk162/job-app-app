# Vercel Environment Variables Setup Guide

## 🎯 Quick Answer to Your Questions

### Q: Is `GOOGLE_CREDENTIALS_JSON` the right name?
**A: YES** - I updated the code to use this variable name for Vercel.

### Q: Does the value need to be wrapped in quotes?
**A: NO** - Paste the raw JSON without wrapping quotes. Vercel handles the formatting.

### Q: Do we need to update code first?
**A: YES - ALREADY DONE!** ✅ The code has been updated to support both local and Vercel deployments.

---

## 📝 Step-by-Step: Setting Environment Variables in Vercel

### Step 1: Push Updated Code to GitHub

```bash
cd job_app_app
git add .
git commit -m "Update Google Sheets auth for Vercel compatibility"
git push origin master
```

### Step 2: Set Environment Variables in Vercel

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Select your project
3. Click **Settings** → **Environment Variables**
4. Add the following variables:

---

## 🔑 Required Environment Variables for Vercel

### 1. GOOGLE_CREDENTIALS_JSON

**Name:** `GOOGLE_CREDENTIALS_JSON`

**Value:** Open your `server/credentials.json` file and copy the ENTIRE contents. It should look like this (with your actual values):

```json
{"type":"service_account","project_id":"your-project-id","private_key_id":"your_key_id","private_key":"-----BEGIN PRIVATE KEY-----\nYourActualPrivateKeyHere...\n-----END PRIVATE KEY-----\n","client_email":"your-service-account@your-project.iam.gserviceaccount.com","client_id":"your_client_id","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url":"https://www.googleapis.com/robot/v1/metadata/x509/your-service-account%40your-project.iam.gserviceaccount.com","universe_domain":"googleapis.com"}
```

**IMPORTANT:**
- ✅ Copy the ENTIRE JSON object as one line
- ✅ NO wrapping quotes
- ✅ Include all the newlines in the private_key (they'll show as `\n`)
- ❌ Don't add extra formatting

**How to copy it correctly:**
```bash
# In your terminal:
cat server/credentials.json | tr -d '\n'
```
This outputs it as a single line - copy that output.

---

### 2. GOOGLE_SHEET_ID

**Name:** `GOOGLE_SHEET_ID`

**Value:** Your Google Sheet ID from the URL

Example: If your sheet URL is:
```
https://docs.google.com/spreadsheets/d/1AbC_XYZ123-abc456/edit
```

The ID is: `1AbC_XYZ123-abc456`

**How to find it:**
1. Open your Google Sheet
2. Look at the URL in your browser
3. Copy the long string between `/d/` and `/edit`

---

### 3. Optional Email Variables (if using Trello integration)

Only add these if you want automatic Trello card creation:

**Name:** `EMAIL_SERVICE`
**Value:** `gmail`

**Name:** `EMAIL_USER`
**Value:** `your_email@gmail.com`

**Name:** `EMAIL_PASSWORD`
**Value:** Your Gmail app password (not your regular password!)

**Name:** `TRELLO_EMAIL`
**Value:** Your Trello board email (e.g., `boardname+uniqueid@app.trello.com`)

---

## 🚀 After Setting Variables

1. Go to **Deployments** tab in Vercel
2. Click the **"..."** menu on the latest deployment
3. Click **"Redeploy"**
4. Select **"Use existing Build Cache"** (optional)
5. Click **"Redeploy"**

Your app will now have access to Google Sheets! 🎉

---

## 🧪 Testing

After deployment:

1. Visit your Vercel URL
2. Try adding a new job application
3. Check your Google Sheet to verify the data was added

---

## 🔒 Security Notes

- ✅ Credentials are stored securely in Vercel (encrypted at rest)
- ✅ They're never exposed in your code or Git history
- ✅ Only your Vercel deployment can access them
- ❌ Never commit credentials.json to Git (already in .gitignore)

---

## 📋 Quick Checklist

- [ ] Update code (✅ already done!)
- [ ] Push code to GitHub
- [ ] Add `GOOGLE_CREDENTIALS_JSON` in Vercel
- [ ] Add `GOOGLE_SHEET_ID` in Vercel
- [ ] Add email variables (optional)
- [ ] Redeploy in Vercel
- [ ] Test the app

---

## ❓ Troubleshooting

### "Cannot read property 'spreadsheets' of undefined"
→ `GOOGLE_CREDENTIALS_JSON` is not set or is malformed. Check it's valid JSON.

### "Invalid grant" or authentication errors
→ Make sure the service account has access to your Google Sheet (share the sheet with the `client_email` from credentials.json)

### "GOOGLE_SHEET_ID is not defined"
→ Add the `GOOGLE_SHEET_ID` environment variable in Vercel
