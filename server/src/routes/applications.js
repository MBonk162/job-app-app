import express from 'express'
import {
  getApplications,
  addApplication,
  updateApplication,
  deleteApplication,
  getAnalytics,
  validateSheet,
  getSheetConfig,
  isDemoMode
} from '../services/googleSheets.js'

const router = express.Router()

// Helper to extract sheet ID from request (header or query param)
const getSheetIdFromRequest = (req) => {
  return req.headers['x-sheet-id'] || req.query.sheetId || null
}

// GET all applications
router.get('/', async (req, res) => {
  try {
    const sheetId = getSheetIdFromRequest(req)
    const applications = await getApplications(sheetId)
    res.json({
      applications,
      isDemo: isDemoMode(sheetId)
    })
  } catch (error) {
    console.error('Error fetching applications:', error)
    res.status(500).json({ error: 'Failed to fetch applications', message: error.message })
  }
})

// POST new application
router.post('/', async (req, res) => {
  try {
    const sheetId = getSheetIdFromRequest(req)
    const application = await addApplication(req.body, sheetId)
    res.status(201).json({
      success: true,
      application,
      isDemo: isDemoMode(sheetId)
    })
  } catch (error) {
    console.error('Error adding application:', error)
    res.status(500).json({ error: 'Failed to add application', message: error.message })
  }
})

// PUT update application
router.put('/:id', async (req, res) => {
  try {
    const sheetId = getSheetIdFromRequest(req)
    const application = await updateApplication(req.params.id, req.body, sheetId)
    res.json({
      success: true,
      application,
      isDemo: isDemoMode(sheetId)
    })
  } catch (error) {
    console.error('Error updating application:', error)
    res.status(500).json({ error: 'Failed to update application', message: error.message })
  }
})

// DELETE application
router.delete('/:id', async (req, res) => {
  try {
    const sheetId = getSheetIdFromRequest(req)
    const result = await deleteApplication(req.params.id, sheetId)
    res.json({
      ...result,
      isDemo: isDemoMode(sheetId)
    })
  } catch (error) {
    console.error('Error deleting application:', error)
    res.status(500).json({ error: 'Failed to delete application', message: error.message })
  }
})

// GET analytics
router.get('/analytics', async (req, res) => {
  try {
    const sheetId = getSheetIdFromRequest(req)
    const analytics = await getAnalytics(sheetId)
    res.json(analytics)
  } catch (error) {
    console.error('Error fetching analytics:', error)
    res.status(500).json({ error: 'Failed to fetch analytics', message: error.message })
  }
})

// GET sheet configuration
router.get('/sheet/config', async (req, res) => {
  try {
    const config = getSheetConfig()
    res.json(config)
  } catch (error) {
    console.error('Error fetching sheet config:', error)
    res.status(500).json({ error: 'Failed to fetch sheet config', message: error.message })
  }
})

// POST validate a sheet ID
router.post('/sheet/validate', async (req, res) => {
  try {
    const { sheetId } = req.body
    const result = await validateSheet(sheetId)
    res.json(result)
  } catch (error) {
    console.error('Error validating sheet:', error)
    res.status(500).json({ error: 'Failed to validate sheet', message: error.message })
  }
})

export default router
