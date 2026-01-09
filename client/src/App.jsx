import { useState, useEffect } from 'react'
import Dashboard from './components/Dashboard'
import ApplicationsTable from './components/ApplicationsTable'
import AddApplicationForm from './components/AddApplicationForm'
import EditApplicationForm from './components/EditApplicationForm'
import { getApplications, addApplication, updateApplication, deleteApplication } from './services/api'
import { VERSION_INFO } from './version'

function App() {
  const [applications, setApplications] = useState([])
  const [loading, setLoading] = useState(true)
  const [showAddForm, setShowAddForm] = useState(false)
  const [showEditForm, setShowEditForm] = useState(false)
  const [editingApplication, setEditingApplication] = useState(null)

  useEffect(() => {
    fetchApplications()
  }, [])

  const fetchApplications = async () => {
    try {
      setLoading(true)
      const data = await getApplications()
      setApplications(data)
    } catch (error) {
      console.error('Error fetching applications:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleAddApplication = async (applicationData) => {
    try {
      await addApplication(applicationData)
      await fetchApplications()
      setShowAddForm(false)
    } catch (error) {
      console.error('Error adding application:', error)
      alert('Failed to add application')
    }
  }

  const handleEditApplication = async (id, updates) => {
    try {
      await updateApplication(id, updates)
      await fetchApplications()
      setShowEditForm(false)
      setEditingApplication(null)
    } catch (error) {
      console.error('Error updating application:', error)
      alert('Failed to update application')
    }
  }

  const handleDeleteApplication = async (id) => {
    try {
      await deleteApplication(id)
      await fetchApplications()
    } catch (error) {
      console.error('Error deleting application:', error)
      alert('Failed to delete application')
    }
  }

  const openEditForm = (application) => {
    setEditingApplication(application)
    setShowEditForm(true)
  }

  // Format version info for tooltip
  const versionTooltip = `Version: ${VERSION_INFO.version}\nBuild: ${new Date(VERSION_INFO.buildDate).toLocaleString('en-US', { timeZone: 'UTC', year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })} UTC\nCommit: ${VERSION_INFO.commit}`

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 flex justify-between items-center">
          <h1
            className="text-3xl font-bold text-gray-900 cursor-help"
            title={versionTooltip}
          >
            Job Application Tracker
          </h1>
          <button
            onClick={() => setShowAddForm(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-medium transition"
          >
            + Add Application
          </button>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {loading ? (
          <div className="flex justify-center items-center h-64">
            <div className="text-xl text-gray-600">Loading...</div>
          </div>
        ) : (
          <>
            <Dashboard applications={applications} />
            <div className="mt-8">
              <ApplicationsTable
                applications={applications}
                onRefresh={fetchApplications}
                onEdit={openEditForm}
                onDelete={handleDeleteApplication}
              />
            </div>
          </>
        )}
      </main>

      {/* Add Application Modal */}
      {showAddForm && (
        <AddApplicationForm
          onClose={() => setShowAddForm(false)}
          onSubmit={handleAddApplication}
        />
      )}

      {/* Edit Application Modal */}
      {showEditForm && editingApplication && (
        <EditApplicationForm
          application={editingApplication}
          onClose={() => {
            setShowEditForm(false)
            setEditingApplication(null)
          }}
          onSubmit={handleEditApplication}
        />
      )}
    </div>
  )
}

export default App
