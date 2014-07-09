require 'data_mapper'

module PronosticosDashboard
  class DB
    def self.setup
      log_file = File.expand_path("log/#{ENV['RACK_ENV'].downcase}.log")
      DataMapper::Logger.new(log_file, :debug)
      DataMapper.setup(:default, "postgres://#{ENV['USERNAME']}:#{ENV['PASSWORD']}@#{ENV['HOSTNAME']}/#{ENV['DB_NAME']}")
    end
  end
end
