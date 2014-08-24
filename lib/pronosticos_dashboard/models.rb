require 'active_record'

module PronosticosDashboard
  class Sale < ActiveRecord::Base

    has_many :games

    validates_presence_of [:agency, :date]

    def self.monthly_totals
      group("to_char(date, 'YYYY-MM')").
        select("sum(to_pay_total) AS tpt, sum(commission) AS c,to_char(date, 'YYYY-MM') as dd")
    end

    def self.with_games_counts(dates_range)
      select('sales.id, sales.date, sales.agency, count(games.id) as games_count, sum(games.units) as total_game_units, sum(games.total) as total_game_amount').
        where('sales' => dates_range).
        joins('left outer join games on sales.id = games.sale_id').
        group('sales.id, sales.date, sales.agency')
    end

    def complete?
      games_count = self.attributes['games_count'] || games.count
      total_game_units = self.attributes['total_game_units'] || games.sum('units')
      total_game_amount = self.attributes['total_game_amount'] || games.sum('total')
      games_count == 12 && total_game_units > 0 && total_game_amount > 0
    end

  end

  class Game < ActiveRecord::Base

    belongs_to :sale

  end
end
