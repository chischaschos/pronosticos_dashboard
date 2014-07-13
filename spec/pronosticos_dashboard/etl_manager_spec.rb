require 'spec_helper'

describe PronosticosDashboard::ETLManager do

  context 'consecutive data loads do not break integrity' do
    it 'should save a sample data set into its base tables' do
      data = Marshal.load(File.open File.expand_path('spec/fixtures/dumped_google_spreadsheet'))
      subject.cells = data
      subject.transform

      expect(PronosticosDashboard::Sale.count).to eq 36

      # 36 rows with games
      # 12 games
      expect(PronosticosDashboard::Game.count).to eq 36 * 12


      subject.transform

      expect(PronosticosDashboard::Sale.count).to eq 36
      expect(PronosticosDashboard::Game.count).to eq 36 * 12
    end
  end

end
