require "pronosticos_dashboard/version"

module PronosticosDashboard
  autoload :DB, 'pronosticos_dashboard/db'
  autoload :ETLManager, 'pronosticos_dashboard/etl_manager'
  autoload :Models, 'pronosticos_dashboard/models'
  autoload :Reports, 'pronosticos_dashboard/reports'
  autoload :Tasks, 'pronosticos_dashboard/tasks'
  autoload :WebApp, 'pronosticos_dashboard/web_app'
end
