import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_URL || '/api'

// Sheet configuration storage key
const SHEET_CONFIG_KEY = 'job_tracker_sheet_config'

// Get the current sheet configuration from localStorage
export const getSheetConfig = () => {
  try {
    const stored = localStorage.getItem(SHEET_CONFIG_KEY)
    if (stored) {
      return JSON.parse(stored)
    }
  } catch (e) {
    console.error('Error reading sheet config:', e)
  }
  // Default to demo mode
  return { mode: 'demo', sheetId: null }
}

// Save sheet configuration to localStorage
export const setSheetConfig = (config) => {
  try {
    localStorage.setItem(SHEET_CONFIG_KEY, JSON.stringify(config))
  } catch (e) {
    console.error('Error saving sheet config:', e)
  }
}

// Get headers with sheet ID if configured
const getHeaders = () => {
  const config = getSheetConfig()
  if (config.mode === 'custom' && config.sheetId) {
    return { 'X-Sheet-Id': config.sheetId }
  }
  // For demo mode, send 'demo' to explicitly request demo data
  return { 'X-Sheet-Id': 'demo' }
}

export const getApplications = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/applications`, {
      headers: getHeaders()
    })
    return {
      applications: response.data.applications || [],
      isDemo: response.data.isDemo || false
    }
  } catch (error) {
    console.error('Error fetching applications:', error)
    throw error
  }
}

export const addApplication = async (applicationData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/applications`, applicationData, {
      headers: getHeaders()
    })
    return response.data
  } catch (error) {
    console.error('Error adding application:', error)
    throw error
  }
}

export const updateApplication = async (id, updates) => {
  try {
    const response = await axios.put(`${API_BASE_URL}/applications/${id}`, updates, {
      headers: getHeaders()
    })
    return response.data
  } catch (error) {
    console.error('Error updating application:', error)
    throw error
  }
}

export const deleteApplication = async (id) => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/applications/${id}`, {
      headers: getHeaders()
    })
    return response.data
  } catch (error) {
    console.error('Error deleting application:', error)
    throw error
  }
}

export const getAnalytics = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/analytics`, {
      headers: getHeaders()
    })
    return response.data
  } catch (error) {
    console.error('Error fetching analytics:', error)
    throw error
  }
}

// Validate a sheet ID
export const validateSheetId = async (sheetId) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/applications/sheet/validate`, { sheetId })
    return response.data
  } catch (error) {
    console.error('Error validating sheet:', error)
    throw error
  }
}

// Get server sheet configuration
export const getServerSheetConfig = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/applications/sheet/config`)
    return response.data
  } catch (error) {
    console.error('Error fetching server sheet config:', error)
    throw error
  }
}
