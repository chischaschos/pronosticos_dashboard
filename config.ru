$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load

if ENV['RACK_ENV'] == 'production'
  $stdout.sync = true
end

require 'pronosticos_dashboard'

run PronosticosDashboard::WebApp
