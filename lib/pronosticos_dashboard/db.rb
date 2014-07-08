require 'data_mapper'

module PronosticosDashboard
  class DB
    def self.setup
      DataMapper::Logger.new($stdout, :debug)
      username = ENV['USERNAME']
      password = ENV['PASSWORD']
      db_name = ENV['DB_NAME']
      hostname = ENV['hOSTNAME']
      DataMapper.setup(:default, "postgres://#{username}:#{password}@#{hostname}/#{db_name}")
    end
  end
end
