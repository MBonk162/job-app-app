# Job Application Tracker

A full-stack job application tracking system with web and mobile apps, featuring Google Sheets synchronization and offline-first architecture.

## 📱 Multi-Platform

- **Web App**: React dashboard for desktop browsing
- **Mobile App**: Flutter Android app with offline support (NEW!)
- **Backend**: Node.js/Express API
- **Data Storage**: Google Sheets (cloud) + SQLite (mobile offline)

## Tech Stack

### Web Application
- **Frontend**: React (Vite), Tailwind CSS, Chart.js
- **Backend**: Node.js/Express
- **Data**: Google Sheets API

### Mobile Application (Production Ready!)
- **Framework**: Flutter 3.38.6
- **State Management**: Riverpod 3.x
- **Local Database**: Drift (SQLite)
- **Authentication**: Google Sign-In
- **Sync**: Google Sheets API with two-way sync
- **Build**: Release APK with custom signing key
- **Java**: 21 (Latest LTS)

## Features

### Web App Features
- ✅ Dashboard with stats cards (total apps, response rate, active pipeline, avg days to response)
- ✅ Line chart showing applications over time
- ✅ Applications table (sortable, filterable by status)
- ✅ Add/Edit/Delete applications form
- ✅ Google Sheets integration (read/write)
- ✅ Timezone-safe date handling

### Mobile App Features (Production Ready!)
- ✅ **Offline-first**: Full CRUD without internet
- ✅ **Add/Edit/Delete** applications (19-field form)
- ✅ **Tap-to-edit** with prominent company names
- ✅ **Google Sign-In** authentication
- ✅ **Two-way sync** with Google Sheets
- ✅ **Conflict detection** (last-write-wins)
- ✅ **Clear & Re-sync** option for fixing sync issues
- ✅ **Visual status badges** with color coding
- ✅ **Debug database viewer** for development
- ✅ **Release builds** ready for distribution
- 🚧 Analytics dashboard (planned)
- 🚧 Search and filter (planned)

## Project Structure

```
job_app_app/
├── client/                 # React web frontend
│   ├── src/
│   │   ├── components/     # Dashboard, tables, forms, charts
│   │   ├── services/       # API client
│   │   └── utils/          # Analytics, date utils
│   └── package.json
│
├── server/                 # Node.js backend API
│   ├── src/
│   │   ├── routes/         # REST API routes
│   │   ├── services/       # Google Sheets integration
│   │   └── server.js
│   └── package.json
│
├── mobile/                 # Flutter mobile app (NEW!)
│   ├── lib/
│   │   ├── core/           # Theme, constants, utilities
│   │   ├── features/
│   │   │   ├── auth/       # Google Sign-In
│   │   │   └── applications/
│   │   │       ├── data/   # SQLite, Google Sheets API
│   │   │       ├── domain/ # Business logic, sync engine
│   │   │       └── presentation/  # UI screens, providers
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── README.md           # Mobile-specific setup guide
│
└── README.md               # This file
```

## Getting Started

### Prerequisites
- **Web App**: Node.js (v18+), npm or yarn
- **Mobile App**: Flutter SDK (3.x), Android Studio or VS Code

### Web Application Setup

1. **Install dependencies**:
   ```bash
   # Client
   cd client && npm install

   # Server
   cd ../server && npm install
   ```

2. **Set up environment variables**:
   ```bash
   cd server
   cp .env.example .env
   # Edit .env with your Google Sheets credentials
   ```

3. **Run the application**:
   ```bash
   # Terminal 1: Start backend
   cd server && npm run dev     # http://localhost:5000

   # Terminal 2: Start frontend
   cd client && npm run dev     # http://localhost:3000
   ```

### Mobile Application Setup

See **[mobile/README.md](mobile/README.md)** for detailed setup instructions.

**Quick Start**:
```bash
cd mobile
flutter pub get
flutter run
```

**Test without OAuth**:
- Launch app → "Continue without sign-in (offline only)"
- Add/edit applications offline
- Everything works locally without internet

**To enable sync**:
1. Configure Google OAuth (SHA-1 fingerprint in mobile/README.md)
2. Share Google Sheet with your Gmail account
3. Sign in on mobile app
4. Tap sync button to sync with cloud

## Current Status

✅ **Production Ready** - Both web and mobile apps are fully functional!

### Web Application
- ✅ Fully integrated with Google Sheets
- ✅ Dashboard with real-time analytics
- ✅ Complete CRUD operations
- ✅ Deployed and accessible

### Mobile Application (Android)
- ✅ **Core functionality complete** - All CRUD operations working
- ✅ **Google Sheets sync** - Two-way synchronization working
- ✅ **Release builds ready** - Production APK generation configured
- ✅ **Tested on physical devices** - Verified working on Android phones
- ⏳ Analytics dashboard - Next priority feature

## Next Steps

### Mobile App
1. **Analytics Dashboard** - Implement charts and stats (next priority)
2. **Enhanced UX** - Search, filter, auto-sync on launch
3. **Code Optimization** - Enable minification for smaller APK
4. **App Store** - Optional: Publish to Google Play Store

### Web App
1. **Deployment** - Deploy to Vercel or similar hosting
2. **Additional Features**:
   - Advanced analytics charts
   - Export functionality
   - Dark mode
   - Mobile responsiveness improvements

### Both Platforms
- Real-time notifications
- Offline indicators
- Performance optimizations
- Automated testing

## Data Model

Each application includes the following fields:
- `date_applied` - When application was submitted
- `company` - Company name
- `role_title` - Job title
- `source` - Where you found the job (LinkedIn, Indeed, etc.)
- `application_method` - How you applied
- `salary_min/max` - Salary range
- `location` - Job location
- `company_size` - Company size category
- `role_type` - Job category
- `tech_stack` - Technologies mentioned
- `customized` - Customized cover letter?
- `referral` - Was there a referral?
- `confidence_match` - How good a fit (1-5)
- `response_date` - When you got first response
- `response_type` - Type of response
- `interview_date` - First interview scheduled
- `status` - Current status
- `notes` - Free-form notes

## License

MIT
