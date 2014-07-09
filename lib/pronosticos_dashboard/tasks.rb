require 'rake/dsl_definition'
require 'dotenv/tasks'

module PronosticosDashboard
  module Tasks
    extend Rake::DSL

    desc 'Imports all data to local data store'
    task import: :dotenv do
      PronosticosDashboard::ETLManager.perform
    end

  end
end

