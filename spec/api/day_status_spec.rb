require 'spec_helper'
require 'rack/test'

describe 'Day Status API' do

  include Rack::Test::Methods

  def app
    PronosticosDashboard::WebApp.new
  end

  it 'should return the status per day' do
    get '/api/days_status'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq []
  end

end
