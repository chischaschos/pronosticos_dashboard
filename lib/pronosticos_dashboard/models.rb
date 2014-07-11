require 'active_record'

module PronosticosDashboard
  class Sale < ActiveRecord::Base

    has_many :games

    validates_presence_of [:agency, :date]

    def complete?
      games.count == 12
    end

  end

  class Game < ActiveRecord::Base

    belongs_to :sale

  end
end
