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

### Mobile Application (NEW!)
- **Framework**: Flutter 3.38.6
- **State Management**: Riverpod 3.x
- **Local Database**: Drift (SQLite)
- **Authentication**: Google Sign-In
- **Sync**: Google Sheets API with two-way sync

## Features

### Web App Features
- ✅ Dashboard with stats cards (total apps, response rate, active pipeline, avg days to response)
- ✅ Line chart showing applications over time
- ✅ Applications table (sortable, filterable by status)
- ✅ Add/Edit/Delete applications form
- ✅ Google Sheets integration (read/write)
- ✅ Timezone-safe date handling

### Mobile App Features (NEW!)
- ✅ **Offline-first**: Full CRUD without internet
- ✅ **Add/Edit/Delete** applications (19-field form)
- ✅ **Tap-to-edit** with prominent company names
- ✅ **Google Sign-In** authentication
- ✅ **Two-way sync** with Google Sheets
- ✅ **Conflict detection** (last-write-wins)
- ✅ **Visual status badges** with color coding
- ✅ **Debug database viewer** for development
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

The application is currently using **mock data** for development. The Google Sheets integration will be added in the next phase.

### Mock Data
The server includes 5 sample job applications to demonstrate the dashboard functionality.

## Next Steps

1. **Google Sheets Integration**:
   - Create Google Cloud project
   - Enable Google Sheets API
   - Create OAuth 2.0 credentials
   - Implement authentication flow
   - Replace mock data with real Sheet data

2. **Additional Features** (Phase 2):
   - Advanced analytics charts
   - Insights panel
   - Export functionality
   - Mobile responsiveness improvements
   - Dark mode

3. **Deployment**:
   - Deploy to Vercel
   - Set up environment variables
   - Configure production API endpoints

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
