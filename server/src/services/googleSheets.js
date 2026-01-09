import { google } from 'googleapis'
import dotenv from 'dotenv'
import { sendJobToTrello } from './emailService.js'

dotenv.config()

// Initialize Google Sheets API
// Support both local development (file-based) and Vercel (env var-based) credentials
let authConfig = {
  scopes: ['https://www.googleapis.com/auth/spreadsheets']
}

let credentialsValid = false

if (process.env.GOOGLE_CREDENTIALS_JSON) {
  // Production/Vercel: Use credentials from environment variable
  try {
    authConfig.credentials = JSON.parse(process.env.GOOGLE_CREDENTIALS_JSON)
    credentialsValid = true
    console.log('✅ Google credentials loaded from GOOGLE_CREDENTIALS_JSON')
  } catch (error) {
    console.error('❌ Invalid GOOGLE_CREDENTIALS_JSON format:', error.message)
    console.error('   The environment variable contains invalid JSON.')
    console.error('   Falling back to mock data. Please fix or remove this variable in Vercel.')
  }
} else if (process.env.GOOGLE_APPLICATION_CREDENTIALS) {
  // Local development: Use credentials file
  authConfig.keyFile = process.env.GOOGLE_APPLICATION_CREDENTIALS
  credentialsValid = true
  console.log('✅ Google credentials loaded from file')
} else {
  console.warn('⚠️  No Google credentials configured. Using mock data.')
}

const auth = new google.auth.GoogleAuth(authConfig)

const sheets = google.sheets({ version: 'v4', auth })
const SPREADSHEET_ID = process.env.GOOGLE_SHEET_ID

// Column mapping (A=0, B=1, etc.)
const COLUMNS = {
  date_applied: 0,
  company: 1,
  role_title: 2,
  source: 3,
  application_method: 4,
  salary_min: 5,
  salary_max: 6,
  location: 7,
  company_size: 8,
  role_type: 9,
  tech_stack: 10,
  customized: 11,
  referral: 12,
  confidence_match: 13,
  response_date: 14,
  response_type: 15,
  interview_date: 16,
  status: 17,
  notes: 18
}

// Helper function to convert row array to application object
const rowToApplication = (row, index) => {
  return {
    id: index, // Row index for updates
    date_applied: row[COLUMNS.date_applied] || '',
    company: row[COLUMNS.company] || '',
    role_title: row[COLUMNS.role_title] || '',
    source: row[COLUMNS.source] || '',
    application_method: row[COLUMNS.application_method] || '',
    salary_min: row[COLUMNS.salary_min] ? parseInt(row[COLUMNS.salary_min]) : null,
    salary_max: row[COLUMNS.salary_max] ? parseInt(row[COLUMNS.salary_max]) : null,
    location: row[COLUMNS.location] || '',
    company_size: row[COLUMNS.company_size] || '',
    role_type: row[COLUMNS.role_type] || '',
    tech_stack: row[COLUMNS.tech_stack] || '',
    customized: row[COLUMNS.customized] || 'No',
    referral: row[COLUMNS.referral] || 'No',
    confidence_match: row[COLUMNS.confidence_match] ? parseInt(row[COLUMNS.confidence_match]) : null,
    response_date: row[COLUMNS.response_date] || null,
    response_type: row[COLUMNS.response_type] || null,
    interview_date: row[COLUMNS.interview_date] || null,
    status: row[COLUMNS.status] || 'Applied',
    notes: row[COLUMNS.notes] || ''
  }
}

// Helper function to convert application object to row array
const applicationToRow = (app) => {
  const row = new Array(19).fill('')
  row[COLUMNS.date_applied] = app.date_applied || ''
  row[COLUMNS.company] = app.company || ''
  row[COLUMNS.role_title] = app.role_title || ''
  row[COLUMNS.source] = app.source || ''
  row[COLUMNS.application_method] = app.application_method || ''
  row[COLUMNS.salary_min] = app.salary_min || ''
  row[COLUMNS.salary_max] = app.salary_max || ''
  row[COLUMNS.location] = app.location || ''
  row[COLUMNS.company_size] = app.company_size || ''
  row[COLUMNS.role_type] = app.role_type || ''
  row[COLUMNS.tech_stack] = app.tech_stack || ''
  row[COLUMNS.customized] = app.customized || 'No'
  row[COLUMNS.referral] = app.referral || 'No'
  row[COLUMNS.confidence_match] = app.confidence_match || ''
  row[COLUMNS.response_date] = app.response_date || ''
  row[COLUMNS.response_type] = app.response_type || ''
  row[COLUMNS.interview_date] = app.interview_date || ''
  row[COLUMNS.status] = app.status || 'Applied'
  row[COLUMNS.notes] = app.notes || ''
  return row
}

// Mock data for when credentials aren't configured
const MOCK_APPLICATIONS = [
  {
    id: 2,
    date_applied: '2025-12-15',
    company: 'TechCorp',
    role_title: 'Senior Software Engineer',
    source: 'LinkedIn',
    application_method: 'Online',
    salary_min: 120000,
    salary_max: 150000,
    location: 'Remote',
    company_size: '500-1000',
    role_type: 'Full-Stack',
    tech_stack: 'React, Node.js, PostgreSQL',
    customized: 'Yes',
    referral: 'No',
    confidence_match: 4,
    response_date: '2025-12-20',
    response_type: 'Phone Screen',
    interview_date: '2025-12-28',
    status: 'Phone Screen',
    notes: 'Great company culture'
  },
  {
    id: 3,
    date_applied: '2025-12-18',
    company: 'StartupXYZ',
    role_title: 'Frontend Developer',
    source: 'Indeed',
    application_method: 'Email',
    salary_min: 100000,
    salary_max: 130000,
    location: 'New York, NY',
    company_size: '50-100',
    role_type: 'Frontend',
    tech_stack: 'React, TypeScript, Tailwind',
    customized: 'Yes',
    referral: 'Yes',
    confidence_match: 5,
    response_date: null,
    response_type: null,
    interview_date: null,
    status: 'Applied',
    notes: 'Referred by colleague'
  }
]

// Get all applications
export const getApplications = async () => {
  // Return mock data if credentials aren't valid or sheet ID is missing
  if (!credentialsValid) {
    console.log('📋 Using mock data - Google credentials not configured or invalid')
    return MOCK_APPLICATIONS
  }

  if (!SPREADSHEET_ID) {
    console.log('📋 Using mock data - GOOGLE_SHEET_ID not configured')
    return MOCK_APPLICATIONS
  }

  try {
    console.log(`🔍 Attempting to fetch from Sheet ID: ${SPREADSHEET_ID}`)
    console.log(`🔍 Range: Sheet1!A2:S`)
    console.log(`🔍 Credentials valid: ${credentialsValid}`)

    const response = await sheets.spreadsheets.values.get({
      spreadsheetId: SPREADSHEET_ID,
      range: 'Sheet1!A2:S', // Skip header row, read all data columns
    })

    const rows = response.data.values || []
    console.log(`✅ Successfully fetched ${rows.length} rows from Google Sheets`)

    // Convert rows to application objects and filter out blank rows
    const applications = rows
      .map((row, index) => rowToApplication(row, index + 2)) // +2 because row 1 is header, row 2 is first data
      .filter(app => {
        // Filter out blank rows (rows where company and role_title are both empty)
        return app.company && app.company.trim() !== '' && app.role_title && app.role_title.trim() !== ''
      })

    console.log(`✅ Returning ${applications.length} valid applications (${rows.length - applications.length} blank rows filtered)`)

    return applications
  } catch (error) {
    console.error('❌ Error fetching from Google Sheets:', error.message)
    console.error('❌ Error code:', error.code)
    console.error('❌ Full error:', JSON.stringify(error, null, 2))
    throw new Error(`Failed to fetch applications: ${error.message}`)
  }
}

// Add new application
export const addApplication = async (applicationData) => {
  // Return mock success if credentials aren't valid or sheet ID is missing
  if (!credentialsValid || !SPREADSHEET_ID) {
    console.log('📝 Mock mode - application not saved (credentials not configured or invalid)')
    return { ...applicationData, id: Date.now() }
  }

  try {
    const row = applicationToRow(applicationData)
    console.log('📝 Adding application with data:', JSON.stringify(applicationData, null, 2))
    console.log('📝 Converted to row array (length:', row.length, '):', JSON.stringify(row))

    const response = await sheets.spreadsheets.values.append({
      spreadsheetId: SPREADSHEET_ID,
      range: 'Sheet1!A:A',
      valueInputOption: 'USER_ENTERED',
      insertDataOption: 'INSERT_ROWS',
      requestBody: {
        values: [row]
      }
    })

    console.log('✅ Application added:', response.data.updates)

    // Send email to Trello board (don't wait for it to complete)
    sendJobToTrello(applicationData).then(result => {
      if (result.success) {
        console.log('Successfully sent job to Trello board')
      } else {
        console.log('Failed to send to Trello:', result.error)
      }
    }).catch(err => {
      console.error('Error sending to Trello:', err)
    })

    return applicationData
  } catch (error) {
    console.error('Error adding to Google Sheets:', error.message)
    throw new Error(`Failed to add application: ${error.message}`)
  }
}

// Update application
export const updateApplication = async (id, updates) => {
  // Return mock success if credentials aren't valid or sheet ID is missing
  if (!credentialsValid || !SPREADSHEET_ID) {
    console.log('✏️  Mock mode - application not updated (credentials not configured or invalid)')
    return { ...updates, id }
  }

  try {
    // id is the row number (2-based indexing: row 2 is first data row)
    const rowNumber = parseInt(id)

    // First, get the existing row
    const existingResponse = await sheets.spreadsheets.values.get({
      spreadsheetId: SPREADSHEET_ID,
      range: `Sheet1!A${rowNumber}:S${rowNumber}`,
    })

    const existingRow = existingResponse.data.values?.[0] || []
    const existingApp = rowToApplication(existingRow, rowNumber)

    // Merge updates with existing data
    const updatedApp = { ...existingApp, ...updates }
    const updatedRow = applicationToRow(updatedApp)

    // Update the row
    await sheets.spreadsheets.values.update({
      spreadsheetId: SPREADSHEET_ID,
      range: `Sheet1!A${rowNumber}:S${rowNumber}`,
      valueInputOption: 'USER_ENTERED',
      requestBody: {
        values: [updatedRow]
      }
    })

    console.log(`Application updated at row ${rowNumber}`)
    return updatedApp
  } catch (error) {
    console.error('Error updating Google Sheets:', error.message)
    throw new Error(`Failed to update application: ${error.message}`)
  }
}

// Delete application
export const deleteApplication = async (id) => {
  // Return mock success if credentials aren't valid or sheet ID is missing
  if (!credentialsValid || !SPREADSHEET_ID) {
    console.log('🗑️  Mock mode - application not deleted (credentials not configured or invalid)')
    return { success: true, message: 'Application deleted successfully (mock mode)' }
  }

  try {
    // id is the row number (1-based indexing: row 2 is first data row)
    const rowNumber = parseInt(id)

    // Use batchUpdate to actually delete the row (not just clear it)
    // Google Sheets API uses 0-based indexing for dimensions
    // So row 2 (first data row) = index 1
    const sheetId = 0 // Sheet1 is typically ID 0, adjust if using different sheet

    await sheets.spreadsheets.batchUpdate({
      spreadsheetId: SPREADSHEET_ID,
      requestBody: {
        requests: [
          {
            deleteDimension: {
              range: {
                sheetId: sheetId,
                dimension: 'ROWS',
                startIndex: rowNumber - 1, // Convert to 0-based index
                endIndex: rowNumber // endIndex is exclusive, so this deletes one row
              }
            }
          }
        ]
      }
    })

    console.log(`✅ Application row ${rowNumber} deleted successfully`)
    return { success: true, message: 'Application deleted successfully' }
  } catch (error) {
    console.error('Error deleting from Google Sheets:', error.message)
    throw new Error(`Failed to delete application: ${error.message}`)
  }
}

// Clean up blank rows (utility function)
export const cleanupBlankRows = async () => {
  if (!credentialsValid || !SPREADSHEET_ID) {
    console.log('🧹 Mock mode - cleanup not performed')
    return { success: true, message: 'Cleanup skipped (mock mode)', rowsDeleted: 0 }
  }

  try {
    // Get all rows
    const response = await sheets.spreadsheets.values.get({
      spreadsheetId: SPREADSHEET_ID,
      range: 'Sheet1!A2:S',
    })

    const rows = response.data.values || []
    const sheetId = 0

    // Find blank rows (rows where all cells are empty)
    const deleteRequests = []

    // Iterate in reverse order so deletion indices remain valid
    for (let i = rows.length - 1; i >= 0; i--) {
      const row = rows[i]
      const isBlank = !row || row.every(cell => !cell || cell.trim() === '')

      if (isBlank) {
        // Row i in array corresponds to row i+2 in sheet (0-based array, 1-based sheet, row 1 is header)
        const rowNumber = i + 2
        deleteRequests.push({
          deleteDimension: {
            range: {
              sheetId: sheetId,
              dimension: 'ROWS',
              startIndex: rowNumber - 1,
              endIndex: rowNumber
            }
          }
        })
      }
    }

    if (deleteRequests.length > 0) {
      await sheets.spreadsheets.batchUpdate({
        spreadsheetId: SPREADSHEET_ID,
        requestBody: {
          requests: deleteRequests
        }
      })
      console.log(`🧹 Cleaned up ${deleteRequests.length} blank rows`)
      return { success: true, message: `${deleteRequests.length} blank rows deleted`, rowsDeleted: deleteRequests.length }
    } else {
      console.log('🧹 No blank rows found')
      return { success: true, message: 'No blank rows to clean up', rowsDeleted: 0 }
    }
  } catch (error) {
    console.error('Error cleaning up blank rows:', error.message)
    throw new Error(`Failed to clean up blank rows: ${error.message}`)
  }
}

// Get analytics
export const getAnalytics = async () => {
  try {
    const applications = await getApplications()

    const withResponse = applications.filter(app => app.response_date && app.response_date.trim() !== '').length
    const responseRate = applications.length > 0
      ? ((withResponse / applications.length) * 100).toFixed(1)
      : 0

    const activeStatuses = ['Applied', 'Response', 'Phone Screen', 'Technical', 'Final']
    const activePipeline = applications.filter(app => activeStatuses.includes(app.status)).length

    // Calculate average days to response
    let avgDaysToResponse = 0
    const responsesWithDates = applications.filter(app =>
      app.response_date && app.response_date.trim() !== '' &&
      app.date_applied && app.date_applied.trim() !== ''
    )

    if (responsesWithDates.length > 0) {
      const totalDays = responsesWithDates.reduce((sum, app) => {
        const applied = new Date(app.date_applied)
        const response = new Date(app.response_date)
        const days = Math.floor((response - applied) / (1000 * 60 * 60 * 24))
        return sum + days
      }, 0)
      avgDaysToResponse = Math.round(totalDays / responsesWithDates.length)
    }

    return {
      totalApplications: applications.length,
      responseRate: parseFloat(responseRate),
      activePipeline,
      avgDaysToResponse
    }
  } catch (error) {
    console.error('Error calculating analytics:', error.message)
    throw new Error(`Failed to calculate analytics: ${error.message}`)
  }
}
