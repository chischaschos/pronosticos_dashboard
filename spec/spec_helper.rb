$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

ENV['RACK_ENV'] = 'test'

require 'dotenv'
require 'json'
require 'pronosticos_dashboard'
require 'pry-nav'

Dotenv.load '.env.test'
