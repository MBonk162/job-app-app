function StatsCards({ stats }) {
  const cards = [
    {
      title: 'Total Applications',
      value: stats.totalApplications,
      bgColor: 'bg-blue-50',
      textColor: 'text-blue-700',
      icon: '📝'
    },
    {
      title: 'Response Rate',
      value: `${stats.responseRate}%`,
      bgColor: 'bg-green-50',
      textColor: 'text-green-700',
      icon: '📊'
    },
    {
      title: 'Active Pipeline',
      value: stats.activePipeline,
      bgColor: 'bg-purple-50',
      textColor: 'text-purple-700',
      icon: '🎯'
    },
    {
      title: 'Avg Days to Response',
      value: stats.avgDaysToResponse > 0 ? `${stats.avgDaysToResponse} days` : '-',
      bgColor: 'bg-orange-50',
      textColor: 'text-orange-700',
      icon: '⏱️'
    }
  ]

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
      {cards.map((card, index) => (
        <div
          key={index}
          className={`${card.bgColor} rounded-lg shadow p-6 transition hover:shadow-lg`}
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 mb-1">{card.title}</p>
              <p className={`text-3xl font-bold ${card.textColor}`}>{card.value}</p>
            </div>
            <div className="text-4xl">{card.icon}</div>
          </div>
        </div>
      ))}
    </div>
  )
}

export default StatsCards
