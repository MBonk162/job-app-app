import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import applicationsRouter from '../server/src/routes/applications.js'

dotenv.config()

const app = express()

// Middleware
app.use(cors())
app.use(express.json())

// Routes
app.use('/api/applications', applicationsRouter)

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', message: 'Job Tracker API is running' })
})

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack)
  res.status(500).json({ error: 'Something went wrong!', message: err.message })
})

// Export the Express app for Vercel serverless
export default app
