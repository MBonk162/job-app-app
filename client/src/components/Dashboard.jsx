import { useMemo } from 'react'
import StatsCards from './StatsCards'
import ApplicationsOverTime from './Charts/ApplicationsOverTime'
import {
  calculateResponseRate,
  calculateAvgDaysToResponse,
  calculateActivePipeline,
  getApplicationsOverTime,
  getResponseRateBySource,
  getCompanySizeDistribution
} from '../utils/analytics'

function Dashboard({ applications }) {
  const stats = useMemo(() => {
    return {
      totalApplications: applications.length,
      responseRate: calculateResponseRate(applications),
      activePipeline: calculateActivePipeline(applications),
      avgDaysToResponse: calculateAvgDaysToResponse(applications)
    }
  }, [applications])

  const chartData = useMemo(() => {
    return {
      applicationsOverTime: getApplicationsOverTime(applications),
      responseRateBySource: getResponseRateBySource(applications),
      companySizeDistribution: getCompanySizeDistribution(applications)
    }
  }, [applications])

  return (
    <div className="space-y-6">
      {/* Stats Cards */}
      <StatsCards stats={stats} />

      {/* Charts Section */}
      <div className="bg-white rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-4">Applications Over Time</h2>
        <ApplicationsOverTime data={chartData.applicationsOverTime} />
      </div>

      {/* Additional stats info */}
      {applications.length === 0 && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-6 text-center">
          <p className="text-blue-800 text-lg font-medium">
            Welcome! Click "Add Application" to start tracking your job search.
          </p>
        </div>
      )}
    </div>
  )
}

export default Dashboard
