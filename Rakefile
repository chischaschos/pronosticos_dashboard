require 'bundler/gem_tasks'

$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'dotenv'
Dotenv.load

require 'pronosticos_dashboard'
require 'pronosticos_dashboard/tasks'
require 'active_record'
require 'pry-nav'
PronosticosDashboard::DB.setup

include ActiveRecord::Tasks

seed_loader = Object.new
seed_loader.instance_eval do
  def load_seed
    file = "#{ActiveRecord::Tasks::DatabaseTasks.db_dir}/seeds.rb"
    load file if File.exists?(file)
  end
end

DatabaseTasks.tap do |config|
  config.database_configuration = ActiveRecord::Base.configurations
  config.env = ENV['RACK_ENV']
  config.db_dir = File.expand_path('db')
  config.migrations_paths = File.expand_path('db/migrations')
  config.root = File.expand_path('.')
  config.seed_loader = seed_loader
  config.fixtures_path = File.expand_path('spec/fixtures')
end

load "active_record/railties/databases.rake"
