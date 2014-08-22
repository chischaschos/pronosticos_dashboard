require 'spec_helper'
require 'rack/test'

describe 'Day Status API' do

  include Rack::Test::Methods

  def app
    PronosticosDashboard::WebApp.new
  end

  it 'should return the status per day' do
    app.settings.reporter_start_date = DateTime.now

    get '/api/days_status'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq []
  end

  it 'should return the monthly numbers' do
    get '/api/totals/monthly'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({})
  end

end
