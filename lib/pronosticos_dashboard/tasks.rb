require 'rake/dsl_definition'

module PronosticosDashboard
  module Tasks
    extend Rake::DSL

    desc 'Imports all data to local data store'
    task :import do
      PronosticosDashboard::ETLManager.perform
    end

    namespace :db do
      desc 'Update DB schema'
      task :update do
        PronosticosDashboard::DB.setup
        PronosticosDashboard::Models
        DataMapper.auto_upgrade!
      end
    end

  end
end

