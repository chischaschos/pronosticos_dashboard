$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load '.env.test'

require 'json'
require 'pronosticos_dashboard'
require 'pry-nav'

