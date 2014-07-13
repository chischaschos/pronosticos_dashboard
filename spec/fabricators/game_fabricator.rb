Fabricator(:game, from: 'PronosticosDashboard::Game') do
  name { sequence(:name) {|n| "game_#{n}" } }
  units { rand(100) }
  total {|attrs| attrs[:units] * rand(20) }
end
