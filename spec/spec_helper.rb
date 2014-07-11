$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load '.env.test'

require 'active_record'
require 'database_cleaner'
require 'json'
require 'pronosticos_dashboard'
require 'pry-nav'
require 'fabrication'

PronosticosDashboard::DB.setup

ActiveRecord::Migration.maintain_test_schema! # does not seem to work

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

