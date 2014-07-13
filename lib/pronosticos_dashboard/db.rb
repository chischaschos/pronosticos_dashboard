require 'active_record'

module PronosticosDashboard
  class DB
    def self.configuration
      {
        'development' => {
          'adapter' =>  'postgresql',
          'host' =>     ENV['HOSTNAME'],
          'username' => ENV['USERNAME'],
          'password' => ENV['PASSWORD'],
          'database' => "#{ENV['DB_NAME']}",
          'port' => ENV['PORT']
        },

        'test' => {
          'adapter' =>  'postgresql',
          'host' =>     ENV['HOSTNAME'],
          'username' => ENV['USERNAME'],
          'password' => ENV['PASSWORD'],
          'database' => "#{ENV['DB_NAME']}",
          'port' => ENV['PORT']
        },

        'production' => {
          'adapter' =>  'postgresql',
          'host' =>     ENV['HOSTNAME'],
          'username' => ENV['USERNAME'],
          'password' => ENV['PASSWORD'],
          'database' => "#{ENV['DB_NAME']}",
        }

      }
    end

    def self.setup
      if ENV['RACK_ENV'] == 'production'
        ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
      else
        log_file = File.expand_path("log/#{ENV['RACK_ENV'].downcase}.log")
        ActiveRecord::Base.logger = ActiveSupport::Logger.new(log_file)
      end
      ActiveRecord::Base.configurations = configuration
      ActiveRecord::Base.maintain_test_schema = true
      ActiveRecord::Base.establish_connection(configuration[ENV['RACK_ENV']])
    end
  end
end
