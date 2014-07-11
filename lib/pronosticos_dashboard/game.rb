require 'active_record'

module PronosticosDashboard
  module Models
    class Sale < ActiveRecord::Base

      has_many :games

      validates_presence_of [:agency, :date]

    end

    class Game < ActiveRecord::Base

      belongs_to :sale

    end
  end
end
