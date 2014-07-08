module PronosticosDashboard
  module Models
    class Sale

      include DataMapper::Resource

      property :agency, String, required: true, key: true
      property :date, Date, required: true, key: true
      property :to_pay_subtotal, Float
      property :payments_number, Integer
      property :payments_amount, Float
      property :cancelled_number, Integer
      property :cancelled_amount, Float
      property :commission, Float
      property :to_pay_total, Float

      has n, :games, 'PronosticosDashboard::Models::Game',
        parent_key: [ :agency, :date ]

    end

    class Game

      include DataMapper::Resource

      property :id, Serial
      property :name, String, required: true
      property :units, Integer, required: true
      property :total, Float, required: true

      belongs_to :sale, 'PronosticosDashboard::Models::Sale',
        parent_key: [ :agency, :date ]
    end

    DataMapper.finalize
  end
end
