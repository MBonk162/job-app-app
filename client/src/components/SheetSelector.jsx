import { useState, useEffect } from 'react'
import { getSheetConfig, setSheetConfig, validateSheetId } from '../services/api'

function SheetSelector({ onSheetChange, isDemo }) {
  const [showModal, setShowModal] = useState(false)
  const [config, setConfig] = useState(getSheetConfig())
  const [customSheetId, setCustomSheetId] = useState('')
  const [validating, setValidating] = useState(false)
  const [validationResult, setValidationResult] = useState(null)
  const [error, setError] = useState(null)

  useEffect(() => {
    const storedConfig = getSheetConfig()
    setConfig(storedConfig)
    if (storedConfig.sheetId) {
      setCustomSheetId(storedConfig.sheetId)
    }
  }, [])

  const handleModeChange = async (mode) => {
    if (mode === 'demo') {
      const newConfig = { mode: 'demo', sheetId: null }
      setConfig(newConfig)
      setSheetConfig(newConfig)
      setValidationResult(null)
      setError(null)
      onSheetChange()
      setShowModal(false)
    }
  }

  const handleValidate = async () => {
    if (!customSheetId.trim()) {
      setError('Please enter a Sheet ID')
      return
    }

    setValidating(true)
    setError(null)
    setValidationResult(null)

    try {
      const result = await validateSheetId(customSheetId.trim())
      setValidationResult(result)

      if (result.valid) {
        const newConfig = { mode: 'custom', sheetId: customSheetId.trim(), title: result.title }
        setConfig(newConfig)
        setSheetConfig(newConfig)
      }
    } catch (err) {
      setError('Failed to validate sheet. Please try again.')
    } finally {
      setValidating(false)
    }
  }

  const handleConnect = () => {
    if (validationResult?.valid) {
      onSheetChange()
      setShowModal(false)
    }
  }

  const extractSheetId = (input) => {
    // Handle full Google Sheets URLs
    const urlMatch = input.match(/\/spreadsheets\/d\/([a-zA-Z0-9-_]+)/)
    if (urlMatch) {
      return urlMatch[1]
    }
    // Otherwise assume it's a raw sheet ID
    return input.trim()
  }

  const handleSheetIdChange = (e) => {
    const extracted = extractSheetId(e.target.value)
    setCustomSheetId(extracted)
    setValidationResult(null)
    setError(null)
  }

  return (
    <>
      {/* Status indicator button */}
      <button
        onClick={() => setShowModal(true)}
        className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm font-medium transition ${
          isDemo
            ? 'bg-amber-100 text-amber-800 hover:bg-amber-200'
            : 'bg-green-100 text-green-800 hover:bg-green-200'
        }`}
      >
        <span className={`w-2 h-2 rounded-full ${isDemo ? 'bg-amber-500' : 'bg-green-500'}`} />
        {isDemo ? 'Demo Mode' : 'Connected'}
      </button>

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div className="p-6">
              <div className="flex justify-between items-center mb-4">
                <h2 className="text-xl font-semibold text-gray-900">Data Source</h2>
                <button
                  onClick={() => setShowModal(false)}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>

              {/* Demo Mode Option */}
              <div className="mb-4">
                <button
                  onClick={() => handleModeChange('demo')}
                  className={`w-full p-4 rounded-lg border-2 text-left transition ${
                    config.mode === 'demo'
                      ? 'border-blue-500 bg-blue-50'
                      : 'border-gray-200 hover:border-gray-300'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <div className={`w-4 h-4 rounded-full border-2 flex items-center justify-center ${
                      config.mode === 'demo' ? 'border-blue-500' : 'border-gray-300'
                    }`}>
                      {config.mode === 'demo' && (
                        <div className="w-2 h-2 rounded-full bg-blue-500" />
                      )}
                    </div>
                    <div>
                      <div className="font-medium text-gray-900">Demo Mode</div>
                      <div className="text-sm text-gray-500">
                        View sample data to explore the app
                      </div>
                    </div>
                  </div>
                </button>
              </div>

              {/* Custom Sheet Option */}
              <div className="mb-4">
                <div
                  className={`p-4 rounded-lg border-2 transition ${
                    config.mode === 'custom'
                      ? 'border-blue-500 bg-blue-50'
                      : 'border-gray-200'
                  }`}
                >
                  <div className="flex items-start gap-3">
                    <div className={`w-4 h-4 mt-1 rounded-full border-2 flex items-center justify-center ${
                      config.mode === 'custom' ? 'border-blue-500' : 'border-gray-300'
                    }`}>
                      {config.mode === 'custom' && (
                        <div className="w-2 h-2 rounded-full bg-blue-500" />
                      )}
                    </div>
                    <div className="flex-1">
                      <div className="font-medium text-gray-900">Connect Your Sheet</div>
                      <div className="text-sm text-gray-500 mb-3">
                        Use your own Google Sheet for tracking
                      </div>

                      <div className="space-y-3">
                        <div>
                          <label className="block text-sm font-medium text-gray-700 mb-1">
                            Sheet ID or URL
                          </label>
                          <input
                            type="text"
                            value={customSheetId}
                            onChange={handleSheetIdChange}
                            placeholder="Paste sheet URL or ID"
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                          />
                        </div>

                        <button
                          onClick={handleValidate}
                          disabled={validating || !customSheetId.trim()}
                          className="w-full px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-lg text-sm font-medium disabled:opacity-50 disabled:cursor-not-allowed transition"
                        >
                          {validating ? 'Validating...' : 'Validate Sheet'}
                        </button>

                        {/* Validation Result */}
                        {validationResult && (
                          <div className={`p-3 rounded-lg text-sm ${
                            validationResult.valid
                              ? 'bg-green-50 text-green-800 border border-green-200'
                              : 'bg-red-50 text-red-800 border border-red-200'
                          }`}>
                            {validationResult.valid ? (
                              <>
                                <div className="font-medium">Sheet found!</div>
                                <div>{validationResult.message}</div>
                              </>
                            ) : (
                              <>
                                <div className="font-medium">Cannot access sheet</div>
                                <div>{validationResult.error}</div>
                              </>
                            )}
                          </div>
                        )}

                        {error && (
                          <div className="p-3 rounded-lg text-sm bg-red-50 text-red-800 border border-red-200">
                            {error}
                          </div>
                        )}

                        {validationResult?.valid && (
                          <button
                            onClick={handleConnect}
                            className="w-full px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg text-sm font-medium transition"
                          >
                            Connect & Load Data
                          </button>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* Help text */}
              <div className="text-xs text-gray-500 bg-gray-50 p-3 rounded-lg">
                <strong>To connect your own sheet:</strong>
                <ol className="mt-1 ml-4 list-decimal space-y-1">
                  <li>Create a Google Sheet with the same column structure</li>
                  <li>Share the sheet with the service account email</li>
                  <li>Copy the sheet URL or ID and paste above</li>
                </ol>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  )
}

export default SheetSelector
