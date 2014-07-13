require 'active_record'

module PronosticosDashboard
  class Sale < ActiveRecord::Base

    has_many :games

    validates_presence_of [:agency, :date]

    def self.with_games_counts(dates_range)
      select('sales.id, sales.date, sales.agency, count(games.id) as games_count').
        where('sales' => dates_range).
        joins('left outer join games on sales.id = games.sale_id').
        group('sales.id, sales.date, sales.agency')
    end

    def complete?
      games_count = self.attributes['games_count'] || games.count
      games_count == 12
    end

  end

  class Game < ActiveRecord::Base

    belongs_to :sale

  end
end
