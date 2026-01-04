import { google } from 'googleapis'
import dotenv from 'dotenv'
import { sendJobToTrello } from './emailService.js'

dotenv.config()

// Initialize Google Sheets API
const auth = new google.auth.GoogleAuth({
  keyFile: process.env.GOOGLE_APPLICATION_CREDENTIALS,
  scopes: ['https://www.googleapis.com/auth/spreadsheets']
})

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

// Get all applications
export const getApplications = async () => {
  try {
    const response = await sheets.spreadsheets.values.get({
      spreadsheetId: SPREADSHEET_ID,
      range: 'Sheet1!A2:S', // Skip header row, read all data columns
    })

    const rows = response.data.values || []

    // Convert rows to application objects
    const applications = rows.map((row, index) => rowToApplication(row, index + 2)) // +2 because row 1 is header, row 2 is first data

    return applications
  } catch (error) {
    console.error('Error fetching from Google Sheets:', error.message)
    throw new Error(`Failed to fetch applications: ${error.message}`)
  }
}

// Add new application
export const addApplication = async (applicationData) => {
  try {
    const row = applicationToRow(applicationData)

    const response = await sheets.spreadsheets.values.append({
      spreadsheetId: SPREADSHEET_ID,
      range: 'Sheet1!A2:S',
      valueInputOption: 'USER_ENTERED',
      requestBody: {
        values: [row]
      }
    })

    console.log('Application added:', response.data.updates)

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
  try {
    // id is the row number (2-based indexing: row 2 is first data row)
    const rowNumber = parseInt(id)

    // Delete the row by clearing its contents
    await sheets.spreadsheets.values.clear({
      spreadsheetId: SPREADSHEET_ID,
      range: `Sheet1!A${rowNumber}:S${rowNumber}`,
    })

    console.log(`Application deleted at row ${rowNumber}`)
    return { success: true, message: 'Application deleted successfully' }
  } catch (error) {
    console.error('Error deleting from Google Sheets:', error.message)
    throw new Error(`Failed to delete application: ${error.message}`)
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
