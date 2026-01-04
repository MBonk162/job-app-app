import { useState } from 'react'

function EditApplicationForm({ application, onClose, onSubmit }) {
  const [formData, setFormData] = useState({
    date_applied: application.date_applied || '',
    company: application.company || '',
    role_title: application.role_title || '',
    source: application.source || 'LinkedIn',
    application_method: application.application_method || 'Quick Apply',
    salary_min: application.salary_min || '',
    salary_max: application.salary_max || '',
    location: application.location || '',
    company_size: application.company_size || '',
    role_type: application.role_type || '',
    tech_stack: application.tech_stack || '',
    customized: application.customized || 'No',
    referral: application.referral || 'No',
    confidence_match: application.confidence_match || '3',
    response_date: application.response_date || '',
    response_type: application.response_type || '',
    interview_date: application.interview_date || '',
    status: application.status || 'Applied',
    notes: application.notes || ''
  })

  const handleChange = (e) => {
    const { name, value } = e.target
    setFormData(prev => ({ ...prev, [name]: value }))
  }

  const handleSubmit = (e) => {
    e.preventDefault()

    // Validate required fields
    if (!formData.company || !formData.role_title) {
      alert('Please fill in Company and Role Title')
      return
    }

    // Convert salary fields to numbers
    const submitData = {
      ...formData,
      salary_min: formData.salary_min ? parseInt(formData.salary_min) : null,
      salary_max: formData.salary_max ? parseInt(formData.salary_max) : null,
      confidence_match: parseInt(formData.confidence_match)
    }

    onSubmit(application.id, submitData)
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        {/* Header */}
        <div className="px-6 py-4 border-b border-gray-200 flex justify-between items-center sticky top-0 bg-white">
          <h2 className="text-2xl font-bold text-gray-900">Edit Application</h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 text-2xl font-bold"
          >
            ×
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="px-6 py-4">
          <div className="space-y-4">
            {/* Required Fields Section */}
            <div className="border-b pb-4">
              <h3 className="text-lg font-semibold text-gray-700 mb-3">Basic Information *</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Date Applied *
                  </label>
                  <input
                    type="date"
                    name="date_applied"
                    value={formData.date_applied}
                    onChange={handleChange}
                    required
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Status *
                  </label>
                  <select
                    name="status"
                    value={formData.status}
                    onChange={handleChange}
                    required
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="Applied">Applied</option>
                    <option value="Response">Response</option>
                    <option value="Phone Screen">Phone Screen</option>
                    <option value="Technical">Technical</option>
                    <option value="Final">Final</option>
                    <option value="Offer">Offer</option>
                    <option value="Rejected">Rejected</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Company *
                  </label>
                  <input
                    type="text"
                    name="company"
                    value={formData.company}
                    onChange={handleChange}
                    required
                    placeholder="e.g. Oracle"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Role Title *
                  </label>
                  <input
                    type="text"
                    name="role_title"
                    value={formData.role_title}
                    onChange={handleChange}
                    required
                    placeholder="e.g. Integration Engineer"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>
            </div>

            {/* Application Details */}
            <div className="border-b pb-4">
              <h3 className="text-lg font-semibold text-gray-700 mb-3">Application Details</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Source
                  </label>
                  <select
                    name="source"
                    value={formData.source}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="LinkedIn">LinkedIn</option>
                    <option value="Indeed">Indeed</option>
                    <option value="Referral">Referral</option>
                    <option value="Company Site">Company Site</option>
                    <option value="Recruiter">Recruiter</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Application Method
                  </label>
                  <select
                    name="application_method"
                    value={formData.application_method}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="Quick Apply">Quick Apply</option>
                    <option value="Full Application">Full Application</option>
                    <option value="Email">Email</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Location
                  </label>
                  <input
                    type="text"
                    name="location"
                    value={formData.location}
                    onChange={handleChange}
                    placeholder="e.g. Remote, SF, Austin"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Company Size
                  </label>
                  <select
                    name="company_size"
                    value={formData.company_size}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">Select...</option>
                    <option value="Startup (<100)">Startup (&lt;100)</option>
                    <option value="Mid (100-1000)">Mid (100-1000)</option>
                    <option value="Enterprise (1000+)">Enterprise (1000+)</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Role Type
                  </label>
                  <input
                    type="text"
                    name="role_type"
                    value={formData.role_type}
                    onChange={handleChange}
                    placeholder="e.g. Integration Engineer"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Tech Stack
                  </label>
                  <input
                    type="text"
                    name="tech_stack"
                    value={formData.tech_stack}
                    onChange={handleChange}
                    placeholder="e.g. Python, API, SQL"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>
            </div>

            {/* Salary */}
            <div className="border-b pb-4">
              <h3 className="text-lg font-semibold text-gray-700 mb-3">Compensation</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Salary Min ($)
                  </label>
                  <input
                    type="number"
                    name="salary_min"
                    value={formData.salary_min}
                    onChange={handleChange}
                    placeholder="e.g. 100000"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Salary Max ($)
                  </label>
                  <input
                    type="number"
                    name="salary_max"
                    value={formData.salary_max}
                    onChange={handleChange}
                    placeholder="e.g. 130000"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>
            </div>

            {/* Application Metadata */}
            <div className="border-b pb-4">
              <h3 className="text-lg font-semibold text-gray-700 mb-3">Application Metadata</h3>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Customized Cover Letter?
                  </label>
                  <select
                    name="customized"
                    value={formData.customized}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="No">No</option>
                    <option value="Yes">Yes</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Referral?
                  </label>
                  <select
                    name="referral"
                    value={formData.referral}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="No">No</option>
                    <option value="Yes">Yes</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Confidence Match (1-5)
                  </label>
                  <select
                    name="confidence_match"
                    value={formData.confidence_match}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="1">1 - Low</option>
                    <option value="2">2</option>
                    <option value="3">3 - Medium</option>
                    <option value="4">4</option>
                    <option value="5">5 - High</option>
                  </select>
                </div>
              </div>
            </div>

            {/* Response Tracking */}
            <div className="border-b pb-4">
              <h3 className="text-lg font-semibold text-gray-700 mb-3">Response Tracking</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Response Date
                  </label>
                  <input
                    type="date"
                    name="response_date"
                    value={formData.response_date}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Response Type
                  </label>
                  <select
                    name="response_type"
                    value={formData.response_type}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  >
                    <option value="">None yet</option>
                    <option value="Email">Email</option>
                    <option value="Phone">Phone</option>
                    <option value="Rejection">Rejection</option>
                    <option value="No Response">No Response</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Interview Date
                  </label>
                  <input
                    type="date"
                    name="interview_date"
                    value={formData.interview_date}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>
              </div>
            </div>

            {/* Notes */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Notes
              </label>
              <textarea
                name="notes"
                value={formData.notes}
                onChange={handleChange}
                rows="3"
                placeholder="Any additional notes or context..."
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          {/* Footer Buttons */}
          <div className="flex justify-end gap-3 mt-6 pt-4 border-t">
            <button
              type="button"
              onClick={onClose}
              className="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition"
            >
              Update Application
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

export default EditApplicationForm
