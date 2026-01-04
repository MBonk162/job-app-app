// Calculate response rate
export const calculateResponseRate = (applications) => {
  if (!applications || applications.length === 0) return 0
  const withResponse = applications.filter(app => app.response_date).length
  return ((withResponse / applications.length) * 100).toFixed(1)
}

// Calculate average days to response
export const calculateAvgDaysToResponse = (applications) => {
  if (!applications || applications.length === 0) return 0

  const applicationsWithResponse = applications.filter(app => app.response_date && app.date_applied)
  if (applicationsWithResponse.length === 0) return 0

  const totalDays = applicationsWithResponse.reduce((sum, app) => {
    const applied = new Date(app.date_applied)
    const response = new Date(app.response_date)
    const days = Math.floor((response - applied) / (1000 * 60 * 60 * 24))
    return sum + days
  }, 0)

  return Math.round(totalDays / applicationsWithResponse.length)
}

// Calculate active pipeline count
export const calculateActivePipeline = (applications) => {
  if (!applications || applications.length === 0) return 0

  const activeStatuses = ['Applied', 'Response', 'Phone Screen', 'Technical', 'Final']
  return applications.filter(app => activeStatuses.includes(app.status)).length
}

// Get applications over time data for charts
export const getApplicationsOverTime = (applications) => {
  if (!applications || applications.length === 0) return { labels: [], data: [] }

  // Group applications by date
  const groupedByDate = applications.reduce((acc, app) => {
    const date = app.date_applied
    if (date) {
      acc[date] = (acc[date] || 0) + 1
    }
    return acc
  }, {})

  // Sort dates and create arrays
  const sortedDates = Object.keys(groupedByDate).sort()
  const cumulativeData = []
  let cumulative = 0

  sortedDates.forEach(date => {
    cumulative += groupedByDate[date]
    cumulativeData.push(cumulative)
  })

  return {
    labels: sortedDates,
    data: cumulativeData
  }
}

// Get response rate by source
export const getResponseRateBySource = (applications) => {
  if (!applications || applications.length === 0) return { labels: [], data: [] }

  const sourceStats = applications.reduce((acc, app) => {
    const source = app.source || 'Unknown'
    if (!acc[source]) {
      acc[source] = { total: 0, responses: 0 }
    }
    acc[source].total++
    if (app.response_date) {
      acc[source].responses++
    }
    return acc
  }, {})

  const labels = Object.keys(sourceStats)
  const data = labels.map(source => {
    const { total, responses } = sourceStats[source]
    return total > 0 ? ((responses / total) * 100).toFixed(1) : 0
  })

  return { labels, data }
}

// Get company size distribution
export const getCompanySizeDistribution = (applications) => {
  if (!applications || applications.length === 0) return { labels: [], data: [] }

  const sizeCount = applications.reduce((acc, app) => {
    const size = app.company_size || 'Unknown'
    acc[size] = (acc[size] || 0) + 1
    return acc
  }, {})

  return {
    labels: Object.keys(sizeCount),
    data: Object.values(sizeCount)
  }
}

// Format date for display
export const formatDate = (dateString) => {
  if (!dateString) return '-'
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
}
