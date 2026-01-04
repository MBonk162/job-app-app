# Job Application Tracker Dashboard

A full-stack web application to track job applications and generate actionable analytics to optimize your job search strategy.

## Tech Stack

- **Frontend**: React (Vite), Tailwind CSS, Chart.js
- **Backend**: Node.js/Express
- **Data**: Google Sheets API (currently using mock data)
- **Deploy**: Vercel (planned)

## Features

### MVP Features
- Dashboard with stats cards (total apps, response rate, active pipeline, avg days to response)
- Line chart showing applications over time
- Applications table (sortable, filterable by status)
- "Add Application" form (modal popup)
- Google Sheets integration (read/write) - coming soon

## Project Structure

```
job_app_app/
├── client/                 # React frontend
│   ├── src/
│   │   ├── components/
│   │   │   ├── Dashboard.jsx
│   │   │   ├── StatsCards.jsx
│   │   │   ├── ApplicationsTable.jsx
│   │   │   ├── AddApplicationForm.jsx
│   │   │   └── Charts/
│   │   │       └── ApplicationsOverTime.jsx
│   │   ├── services/
│   │   │   └── api.js
│   │   ├── utils/
│   │   │   └── analytics.js
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
├── server/                 # Node.js backend
│   ├── src/
│   │   ├── routes/
│   │   │   └── applications.js
│   │   ├── services/
│   │   │   └── googleSheets.js
│   │   └── server.js
│   └── package.json
└── README.md
```

## Getting Started

### Prerequisites
- Node.js (v18 or higher)
- npm or yarn

### Installation

1. **Install client dependencies**:
   ```bash
   cd client
   npm install
   ```

2. **Install server dependencies**:
   ```bash
   cd ../server
   npm install
   ```

3. **Set up environment variables** (optional for now):
   ```bash
   cp .env.example .env
   # Edit .env with your Google Sheets credentials when ready
   ```

### Running the Application

1. **Start the backend server** (in one terminal):
   ```bash
   cd server
   npm run dev
   ```
   Server will run on http://localhost:5000

2. **Start the frontend** (in another terminal):
   ```bash
   cd client
   npm run dev
   ```
   Client will run on http://localhost:3000

3. **Open your browser** and navigate to http://localhost:3000

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
