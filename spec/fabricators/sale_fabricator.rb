Fabricator(:sale, from: 'PronosticosDashboard::Sale') do
  agency { sequence(:agency, 999999999) }
end

Fabricator(:complete_sale, from: :sale) do
  games(count: 12)
end
