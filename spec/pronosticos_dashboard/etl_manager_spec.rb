$LOAD_PATH << File.expand_path('lib/pronosticos_dashboard')

require 'rspec'
require 'json'
require 'pronosticos_dashboard'
require 'pry-nav'

describe PronosticosDashboard::ETLManager do
  before do
    require 'dotenv'
    Dotenv.load
    PronosticosDashboard::DB.setup
    PronosticosDashboard::Models
    DataMapper.auto_migrate!
  end

  it 'should save a sample data set into its base tables' do
    data = Marshal.load(File.open File.expand_path('spec/fixtures/data'))
    subject.cells = data
    subject.transform

    expect(PronosticosDashboard::Models::Sale.count).to eq 36

    # 36 rows with games
    # 12 games
    expect(PronosticosDashboard::Models::Game.count).to eq 36 * 12
  end

end
