$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load '.env.test'

require 'capybara/cucumber'
require 'capybara-webkit'
require 'pry-nav'
require 'pronosticos_dashboard'
require 'rspec/expectations'

Capybara.javascript_driver = :webkit
Capybara.app = PronosticosDashboard::WebApp
