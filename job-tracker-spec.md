# Job Application Tracker + Analytics Dashboard
## Project Specification Document

---

## **Project Overview**

**Purpose**: Build a full-stack web application to track job applications and generate actionable analytics to optimize job search strategy.

**Primary Goals**:
- Track all job applications in a structured way
- Visualize application patterns and success rates
- Identify what strategies are working (and what aren't)
- Serve as a portfolio piece demonstrating technical skills
- Provide daily motivation through visible pipeline progress

**Target User**: Motch (you) - currently job searching, needs data-driven insights to optimize application strategy

---

## **Core Problem Being Solved**

### **Current Pain Points**:
- Applications tracked mentally or in scattered notes
- No visibility into what's working (company size, role type, application method)
- Hard to maintain motivation without seeing pipeline growth
- Missing pattern recognition (e.g., "mid-size companies respond 3x more than startups")
- No clear answer to "how many days until I should follow up?"

### **Success Criteria**:
- Can answer "What's my response rate?" instantly
- Can identify which job sources yield best results
- Can see active pipeline at a glance
- Provides actionable insights ("Focus on Integration Engineer roles - 35% response rate vs 12% for BA roles")
- Serves as talking point in interviews

---

## **Tech Stack**

### **Frontend**
- **Framework**: React (with Vite for build tooling)
- **Styling**: Tailwind CSS (for rapid, professional styling)
- **Charts**: Chart.js or Recharts (for data visualization)
- **State Management**: React hooks (useState, useEffect) - keep it simple

### **Backend**
- **Runtime**: Node.js
- **Framework**: Express (lightweight API layer)
- **API Integration**: Google Sheets API (data source)

### **Data Storage**
- **Primary**: Google Sheets (acts as database)
- **Rationale**: 
  - Already using Google Sheets for tracking
  - Easy to edit on mobile
  - Free
  - Familiar interface
  - No database setup needed

### **Deployment**
- **Hosting**: Vercel (free tier, excellent for React apps)
- **Version Control**: GitHub
- **CI/CD**: Vercel auto-deploys from GitHub main branch

---

## **Data Model**

### **Google Sheet Structure**

| Column Name | Data Type | Description | Example |
|-------------|-----------|-------------|---------|
| date_applied | Date | When application was submitted | 2024-12-15 |
| company | Text | Company name | Oracle |
| role_title | Text | Job title | Integration Engineer |
| source | Text | Where you found the job | LinkedIn, Indeed, Referral, Company Site |
| application_method | Text | How you applied | Quick Apply, Full Application, Email |
| salary_min | Number | Minimum salary (if listed) | 110000 |
| salary_max | Number | Maximum salary (if listed) | 130000 |
| location | Text | Job location | Remote, SF, Austin |
| company_size | Text | Company size category | Startup (<100), Mid (100-1000), Enterprise (1000+) |
| role_type | Text | Job category | Technical BA, Integration Engineer, Data Engineer |
| tech_stack | Text | Technologies mentioned | Python, Java, API, SQL |
| customized | Boolean | Did you customize cover letter? | Yes, No |
| referral | Boolean | Was there a referral? | Yes, No |
| confidence_match | Number | How good a fit (1-5) | 4 |
| response_date | Date | When you got first response | 2024-12-18 |
| response_type | Text | Type of response | Email, Phone, Rejection, No Response |
| interview_date | Date | First interview scheduled | 2024-12-20 |
| status | Text | Current status | Applied, Response, Phone Screen, Technical, Final, Offer, Rejected |
| notes | Text | Free-form notes | "Referred by John, hiring manager seems engaged" |

### **Calculated Fields** (computed in dashboard, not stored):
- `days_to_response`: response_date - date_applied
- `days_in_stage`: today - date_applied (for active applications)
- `response_rate`: applications with response / total applications
- `active_pipeline`: count where status in (Applied, Response, Phone Screen, Technical, Final)

---

## **Features & User Stories**

### **Phase 1: MVP (Core Functionality)**

#### **Dashboard Home**
**As a user, I want to see an overview of my job search at a glance.**

Components:
- **Stats Cards** (4 cards across top):
  - Total Applications
  - Response Rate (with % and trend indicator)
  - Active Pipeline (applications in progress)
  - Avg Days to Response

- **Primary Chart** (line chart):
  - Applications over time (by date_applied)
  - Color-coded by status
  - Tooltips showing details on hover

- **Secondary Charts** (2 columns):
  - Response Rate by Source (bar chart)
  - Company Size Distribution (pie chart)

- **Recent Activity Feed**:
  - Last 5 applications (chronological)
  - Last 3 responses
  - Upcoming interviews

#### **Applications Table**
**As a user, I want to view and manage all my applications in one place.**

Features:
- **Full table view** with all columns
- **Sortable** by any column (date, company, status)
- **Filterable**:
  - By status (Applied, Response, etc.)
  - By source (LinkedIn, Indeed, etc.)
  - By date range (last 7 days, last 30 days, custom)
- **Search** by company name or role title
- **Color-coded rows** by status:
  - Applied: light blue
  - Response: green
  - Interview: yellow
  - Rejected: red
  - Offer: gold
- **Click to expand** for full notes/details
- **Quick edit** inline for status updates

#### **Add Application Form**
**As a user, I want to quickly log a new application.**

Features:
- **Modal popup** (overlay, doesn't leave page)
- **Form fields** (all from data model above)
- **Required fields**: date_applied, company, role_title, source, status
- **Auto-save to Google Sheet** on submit
- **Keyboard shortcut**: `Cmd+N` to open form
- **Quick defaults**:
  - date_applied = today
  - status = "Applied"
  - customized = No
  - referral = No

#### **Google Sheets Integration**
**As a user, I want my dashboard to read from my existing Google Sheet.**

Technical:
- **OAuth 2.0** authentication with Google
- **Read access** to specified Google Sheet
- **Write access** for adding new applications via form
- **Sync button** to manually refresh data
- **Auto-refresh** on page load
- **Error handling** if Sheet is unavailable

---

### **Phase 2: Analytics & Insights**

#### **Insights Panel**
**As a user, I want automated insights about my job search patterns.**

Auto-generated insights:
- "Your response rate improved 15% this week" (trend analysis)
- "Mid-size companies respond 40% of the time vs 12% for startups" (company size)
- "Applications with referrals have 60% response rate vs 15% without" (referral value)
- "You're getting best results on Integration Engineer roles (35% response rate)" (role type)
- "Applications pending 14+ days: 8 - consider following up" (action items)
- "Your confidence-4 applications have 50% response rate vs 0% for confidence-5" (calibration)

#### **Advanced Charts**
- **Funnel Visualization**:
  - 100 Applications → 20 Responses → 15 Phone Screens → 8 Technical → 3 Final → 1 Offer
  - Shows conversion rates at each stage
  - Identifies bottlenecks ("You're losing at the technical interview stage")

- **Heatmap Calendar**:
  - Visual grid showing application activity by day
  - Green intensity = number of applications
  - Blue dots = interview days
  - Red dots = rejection days

- **Time-to-Response Distribution**:
  - Histogram showing days until response
  - Helps identify "dead zone" (if no response after X days, unlikely to hear back)

- **Salary vs Response Rate**:
  - Scatter plot showing if you're reaching too high or too low
  - Clusters show sweet spots

#### **Comparison Views**
- **Source Performance**:
  - Table comparing LinkedIn vs Indeed vs Referrals vs Company Sites
  - Columns: Total Applied, Response Rate, Avg Days to Response, Interviews Generated

- **Role Type Performance**:
  - Compare Technical BA vs Integration Engineer vs Data Engineer
  - Helps identify where you're most competitive

---

### **Phase 3: Polish & Enhancements**

#### **UI/UX Improvements**
- **Dark Mode Toggle** (save preference to localStorage)
- **Mobile Responsive** (works on phone for quick updates)
- **Loading States** (skeleton screens while fetching data)
- **Empty States** (helpful messaging when no data yet)
- **Toast Notifications** ("Application added successfully!")

#### **Export & Sharing**
- **Export to CSV** button (download all data)
- **Share Dashboard** (generate shareable link for interviews)
- **Print-Friendly View** (clean version for printing)

#### **Advanced Features** (nice-to-have)
- **Job Description Analysis** (paste JD, extract required skills)
- **Email Integration** (parse confirmation emails to auto-log applications)
- **Browser Extension** (capture job details while browsing)
- **Reminders** (follow up if no response after X days)

---

## **Analytics Specifications**

### **Key Metrics to Display**

1. **Response Rate**
   - Formula: `(# with response_date) / (total applications) * 100`
   - Display: "24%" with trend arrow (↑ 5% from last week)

2. **Average Days to Response**
   - Formula: `AVG(response_date - date_applied)` where response_date exists
   - Display: "8 days" with comparison to industry average

3. **Active Pipeline**
   - Formula: `COUNT where status IN (Applied, Response, Phone Screen, Technical, Final)`
   - Display: "12 active" with breakdown by stage

4. **Application Velocity**
   - Formula: Applications per week over time
   - Display: Line chart showing momentum

5. **Conversion Rates**
   - Applied → Response: X%
   - Response → Phone Screen: X%
   - Phone Screen → Technical: X%
   - Technical → Offer: X%

### **Segmentation Analysis**

**By Source**:
- LinkedIn: X applications, Y% response rate
- Indeed: X applications, Y% response rate
- Referrals: X applications, Y% response rate
- Company Sites: X applications, Y% response rate

**By Company Size**:
- Startups (<100): X applications, Y% response rate
- Mid-size (100-1000): X applications, Y% response rate
- Enterprise (1000+): X applications, Y% response rate

**By Role Type**:
- Technical BA: X applications, Y% response rate
- Integration Engineer: X applications, Y% response rate
- Data Engineer: X applications, Y% response rate

**By Customization**:
- Customized applications: X%, Y% response rate
- Non-customized: X%, Y% response rate

**By Salary Range**:
- $80-100k: X applications, Y% response rate
- $100-120k: X applications, Y% response rate
- $120k+: X applications, Y% response rate

---

## **Technical Implementation Details**

### **Project Structure**
```
job-tracker/
├── client/                 # React frontend
│   ├── src/
│   │   ├── components/
│   │   │   ├── Dashboard.jsx
│   │   │   ├── StatsCards.jsx
│   │   │   ├── ApplicationsTable.jsx
│   │   │   ├── AddApplicationForm.jsx
│   │   │   ├── Charts/
│   │   │   │   ├── ApplicationsOverTime.jsx
│   │   │   │   ├── ResponseRateBySource.jsx
│   │   │   │   └── CompanySizeDistribution.jsx
│   │   │   └── InsightsPanel.jsx
│   │   ├── services/
│   │   │   └── api.js           # API calls to backend
│   │   ├── utils/
│   │   │   └── analytics.js     # Analytics calculations
│   │   ├── App.jsx
│   │   └── main.jsx
│   ├── public/
│   └── package.json
├── server/                 # Node.js backend
│   ├── src/
│   │   ├── routes/
│   │   │   └── applications.js
│   │   ├── services/
│   │   │   └── googleSheets.js  # Google Sheets API integration
│   │   └── server.js
│   └── package.json
├── .env.example           # Environment variables template
├── README.md
└── package.json
```

### **API Endpoints**

**GET /api/applications**
- Returns all applications from Google Sheet
- Response: `{ applications: [...] }`

**POST /api/applications**
- Adds new application to Google Sheet
- Body: `{ date_applied, company, role_title, ... }`
- Response: `{ success: true, application: {...} }`

**PUT /api/applications/:id**
- Updates existing application (by row number)
- Body: `{ status: "Phone Screen", interview_date: "2024-12-20" }`
- Response: `{ success: true, application: {...} }`

**GET /api/analytics**
- Returns computed analytics
- Response: `{ response_rate, avg_days_to_response, active_pipeline, ... }`

**GET /api/insights**
- Returns auto-generated insights
- Response: `{ insights: ["Insight 1", "Insight 2", ...] }`

### **Google Sheets API Setup**

**Required Steps**:
1. Create Google Cloud project
2. Enable Google Sheets API
3. Create OAuth 2.0 credentials
4. Add authorized redirect URIs
5. Store credentials in `.env` file

**Environment Variables**:
```
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
GOOGLE_SHEET_ID=your_sheet_id
GOOGLE_REDIRECT_URI=http://localhost:3000/auth/callback
```

**Authentication Flow**:
1. User clicks "Connect to Google Sheets"
2. Redirected to Google OAuth consent screen
3. User grants permission
4. Redirected back with auth code
5. Exchange code for access token
6. Store token (encrypted) in localStorage
7. Use token for all Sheet API calls

---

## **Development Workflow with Claude Code**

### **Session 1: Project Scaffolding (2-3 hours)**

**Prompt for Claude Code**:
```
I want to build a job application tracker dashboard. Here are the requirements:

Tech Stack:
- Frontend: React (Vite), Tailwind CSS, Chart.js
- Backend: Node.js/Express
- Data: Google Sheets API
- Deploy: Vercel

Features for MVP:
1. Dashboard with stats cards (total apps, response rate, active pipeline, avg days to response)
2. Line chart showing applications over time
3. Applications table (sortable, filterable by status)
4. "Add Application" form (modal popup)
5. Google Sheets integration (read/write)

Please scaffold the entire project structure, set up the development environment, 
and get a basic version running locally. Use the data model from the spec doc I'll provide.
```

**Expected Outputs**:
- Full project structure created
- Dependencies installed
- Dev server running on localhost:3000
- Basic React components scaffolded
- Express server set up

### **Session 2: Google Sheets Integration (2-3 hours)**

**Prompt for Claude Code**:
```
Now let's connect to my actual Google Sheet:
- Sheet ID: [your_sheet_id]
- Set up OAuth 2.0 authentication
- Implement API endpoints to read/write data
- Display real data in the applications table
- Add sync button to refresh data

Guide me through creating the Google Cloud project and getting credentials.
```

**Expected Outputs**:
- Google Sheets API fully integrated
- OAuth flow working
- Real data displayed in table
- Add/edit functionality working

### **Session 3: Charts & Analytics (2-3 hours)**

**Prompt for Claude Code**:
```
Add these analytics and visualizations:
1. Line chart: Applications over time (by date_applied)
2. Bar chart: Response rate by source (LinkedIn, Indeed, etc.)
3. Pie chart: Company size distribution
4. Stats calculations: response rate, avg days to response, active pipeline
5. Insights panel with auto-generated observations

Use the analytics specifications from the spec doc.
```

**Expected Outputs**:
- All charts rendering with real data
- Analytics calculations accurate
- Insights panel showing actionable observations

### **Session 4: Polish & Deploy (2-3 hours)**

**Prompt for Claude Code**:
```
Final polish:
1. Make fully responsive (mobile-friendly)
2. Add dark mode toggle
3. Improve styling (professional look)
4. Add loading states and error handling
5. Deploy to Vercel

Walk me through the deployment process.
```

**Expected Outputs**:
- Professional, polished UI
- Deployed to Vercel with live URL
- GitHub repo set up with clean commit history

---

## **Success Metrics (Project Evaluation)**

### **Functional Success**:
- ✅ Can add applications via form
- ✅ Can view all applications in table
- ✅ Can filter/sort applications
- ✅ Charts render correctly with real data
- ✅ Analytics are accurate
- ✅ Insights are actionable
- ✅ Deploys successfully to Vercel

### **Portfolio Success**:
- ✅ Clean, professional UI
- ✅ Responsive design (works on mobile)
- ✅ Well-structured code
- ✅ README explains the project
- ✅ Live demo available
- ✅ GitHub repo showcases commit history

### **Personal Success**:
- ✅ Actually using it daily for job search
- ✅ Insights lead to strategy changes
- ✅ Feels confident explaining it in interviews
- ✅ Learned React/frontend patterns
- ✅ Completed full-stack project start-to-finish

---

## **Timeline & Effort Estimate**

### **Focused Sprint (Recommended)**:
- **Weekend 1**: Sessions 1 & 2 (scaffold + data integration) - 5-6 hours
- **Weekend 2**: Sessions 3 & 4 (analytics + deploy) - 5-6 hours
- **Total**: 10-12 hours over 2 weekends

### **Slow Burn Alternative**:
- **Week 1-2**: Session 1 (scaffold) - 2-3 hours
- **Week 3**: Session 2 (data) - 2-3 hours
- **Week 4**: Session 3 (analytics) - 2-3 hours
- **Week 5**: Session 4 (deploy) - 2-3 hours
- **Total**: 10-12 hours over 5 weeks

---

## **Interview Talking Points**

**When asked about projects**:
> "While job searching, I built a full-stack dashboard to track and analyze my applications. 
> I realized I was applying somewhat randomly with no data on what was working.
>
> The app pulls from a Google Sheet via their API, calculates response rates across different 
> dimensions (company size, job source, role type), and visualizes trends using Chart.js.
>
> After tracking 50+ applications, the data showed mid-size companies responded 3x more than 
> startups, and customized applications had 4x the success rate. I pivoted my strategy based 
> on these insights—my response rate jumped from 12% to 35%.
>
> It's built with React, Node.js, and deployed on Vercel. The project demonstrates full-stack 
> development, API integration, data visualization, and solving a real problem I was experiencing."

**When asked about technical choices**:
> "I chose Google Sheets as the backend because I was already tracking applications in a sheet—
> this approach let me add analytics without migrating data. The Sheets API is well-documented 
> and handles auth cleanly.
>
> For the frontend, I went with React and Chart.js to get experience with modern component-based 
> architecture and data visualization. Vercel deployment was straightforward—push to GitHub and 
> it auto-deploys.
>
> If I were to scale this for multiple users, I'd migrate to a proper database like PostgreSQL 
> and add user authentication, but for a personal tool, Sheets works great."

**When asked about challenges**:
> "The trickiest part was OAuth 2.0 flow with Google—getting the credentials set up and handling 
> token refresh. I also had to think through how to calculate meaningful analytics from sparse 
> data early in the job search.
>
> I solved the analytics challenge by building progressive insights—the app shows what it can 
> with limited data ('You've applied to 10 jobs') and adds depth as more data comes in 
> ('Mid-size companies respond 40% vs 12% for startups')."

---

## **Next Steps**

1. **Prep Your Google Sheet**:
   - Create sheet with column headers from data model
   - Add 3-5 sample rows of data (use real applications if available)
   - Note the Sheet ID from the URL

2. **Open Claude Code**:
   - Share this spec document
   - Start with Session 1 prompt

3. **Set Aside Time**:
   - Block 3 hours this weekend for Session 1
   - Goal: See working prototype by Sunday evening

4. **Commit to 2 Weekends**:
   - Weekend 1: Sessions 1 & 2 (foundation)
   - Weekend 2: Sessions 3 & 4 (analytics + deploy)

---

## **Appendix: Data Model Examples**

### **Example Row 1**:
```json
{
  "date_applied": "2024-12-15",
  "company": "Oracle",
  "role_title": "Advanced Services Engineer",
  "source": "LinkedIn",
  "application_method": "Full Application",
  "salary_min": 110000,
  "salary_max": 130000,
  "location": "Remote",
  "company_size": "Enterprise (1000+)",
  "role_type": "Integration Engineer",
  "tech_stack": "API, Python, Java",
  "customized": "Yes",
  "referral": "No",
  "confidence_match": 4,
  "response_date": "2024-12-18",
  "response_type": "Email",
  "interview_date": "2024-12-20",
  "status": "Phone Screen",
  "notes": "Hiring manager seems engaged, technical round scheduled for next week"
}
```

### **Example Row 2**:
```json
{
  "date_applied": "2024-12-16",
  "company": "Sardine",
  "role_title": "Integration Engineer",
  "source": "Indeed",
  "application_method": "Quick Apply",
  "salary_min": 95000,
  "salary_max": 115000,
  "location": "San Francisco",
  "company_size": "Mid (100-1000)",
  "role_type": "Integration Engineer",
  "tech_stack": "API, Webhooks, Python",
  "customized": "No",
  "referral": "No",
  "confidence_match": 5,
  "response_date": null,
  "response_type": null,
  "interview_date": null,
  "status": "Applied",
  "notes": "Quick apply, probably won't hear back"
}
```

---

**Document Version**: 1.0  
**Created**: December 2024  
**Author**: Claude (with Motch)  
**Purpose**: Complete specification for Claude Code development sessions
