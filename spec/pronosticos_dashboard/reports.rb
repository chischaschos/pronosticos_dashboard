require 'spec_helper'

describe PronosticosDashboard::Reports do
  subject(:reports) { PronosticosDashboard::Reports }

  it 'should return the days status' do
    expect(reports.days_status).to eq []
  end
end
