import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_URL || '/api'

export const getApplications = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/applications`)
    return response.data.applications || []
  } catch (error) {
    console.error('Error fetching applications:', error)
    throw error
  }
}

export const addApplication = async (applicationData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/applications`, applicationData)
    return response.data
  } catch (error) {
    console.error('Error adding application:', error)
    throw error
  }
}

export const updateApplication = async (id, updates) => {
  try {
    const response = await axios.put(`${API_BASE_URL}/applications/${id}`, updates)
    return response.data
  } catch (error) {
    console.error('Error updating application:', error)
    throw error
  }
}

export const deleteApplication = async (id) => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/applications/${id}`)
    return response.data
  } catch (error) {
    console.error('Error deleting application:', error)
    throw error
  }
}

export const getAnalytics = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/analytics`)
    return response.data
  } catch (error) {
    console.error('Error fetching analytics:', error)
    throw error
  }
}
