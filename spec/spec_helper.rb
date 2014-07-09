$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load '.env.test'

require 'database_cleaner'
require 'json'
require 'pronosticos_dashboard'
require 'pry-nav'

RSpec.configure do |config|

  config.before(:suite) do
    PronosticosDashboard::DB.setup
    PronosticosDashboard::Models
    DataMapper.auto_migrate!
    DatabaseCleaner[:data_mapper].strategy = :transaction
    DatabaseCleaner[:data_mapper].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:data_mapper].start
  end

  config.after(:each) do
    DatabaseCleaner[:data_mapper].clean
  end
end

