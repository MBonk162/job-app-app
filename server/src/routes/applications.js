import express from 'express'
import { getApplications, addApplication, updateApplication, deleteApplication, getAnalytics } from '../services/googleSheets.js'

const router = express.Router()

// GET all applications
router.get('/', async (req, res) => {
  try {
    const applications = await getApplications()
    res.json({ applications })
  } catch (error) {
    console.error('Error fetching applications:', error)
    res.status(500).json({ error: 'Failed to fetch applications', message: error.message })
  }
})

// POST new application
router.post('/', async (req, res) => {
  try {
    const application = await addApplication(req.body)
    res.status(201).json({ success: true, application })
  } catch (error) {
    console.error('Error adding application:', error)
    res.status(500).json({ error: 'Failed to add application', message: error.message })
  }
})

// PUT update application
router.put('/:id', async (req, res) => {
  try {
    const application = await updateApplication(req.params.id, req.body)
    res.json({ success: true, application })
  } catch (error) {
    console.error('Error updating application:', error)
    res.status(500).json({ error: 'Failed to update application', message: error.message })
  }
})

// DELETE application
router.delete('/:id', async (req, res) => {
  try {
    const result = await deleteApplication(req.params.id)
    res.json(result)
  } catch (error) {
    console.error('Error deleting application:', error)
    res.status(500).json({ error: 'Failed to delete application', message: error.message })
  }
})

// GET analytics
router.get('/analytics', async (req, res) => {
  try {
    const analytics = await getAnalytics()
    res.json(analytics)
  } catch (error) {
    console.error('Error fetching analytics:', error)
    res.status(500).json({ error: 'Failed to fetch analytics', message: error.message })
  }
})

export default router
