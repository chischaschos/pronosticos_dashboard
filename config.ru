$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load '.env.test'

require 'pronosticos_dashboard'

run PronosticosDashboard::WebApp
