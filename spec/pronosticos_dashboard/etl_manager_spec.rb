require 'spec_helper'

describe PronosticosDashboard::ETLManager do

  it 'should save a sample data set into its base tables' do
    data = Marshal.load(File.open File.expand_path('spec/fixtures/data'))
    subject.cells = data
    subject.transform

    expect(PronosticosDashboard::Models::Sale.count).to eq 36

    # 36 rows with games
    # 12 games
    expect(PronosticosDashboard::Models::Game.count).to eq 36 * 12
  end

  # TODO: Generate fixtures from current db

end
