require 'spec_helper'

describe PronosticosDashboard::ETLManager do
  before do
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

  # Dump models so they can me used as fixtures in the cucumber tests for example
  after do
    DataMapper::Model.descendants.entries.each do |table|
      file = File.expand_path("spec/fixtures/#{table}.yml")
      File.open(file, 'w+') { |f| f.print table.all.to_yaml }
    end
  end

end
