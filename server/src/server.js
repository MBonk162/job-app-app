import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import applicationsRouter from './routes/applications.js'

dotenv.config()

const app = express()
const PORT = process.env.PORT || 5000

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

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`)
})
