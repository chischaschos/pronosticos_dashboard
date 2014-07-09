require 'data_mapper'

module PronosticosDashboard
  class DB
    def self.setup
      DataMapper::Logger.new($stdout, :debug)
      DataMapper.setup(:default, "postgres://#{ENV['USERNAME']}:#{ENV['PASSWORD']}@#{ENV['HOSTNAME']}/#{ENV['DB_NAME']}")
    end
  end
end
