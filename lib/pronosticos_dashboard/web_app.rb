require 'sinatra'

module PronosticosDashboard
  class WebApp < Sinatra::Base

    # TODO: user absolute path
    set :root, File.expand_path('.')
    set :reporter_start_date, DateTime.parse('2014-06-16')
    set :reporter_end_date, DateTime.now

    configure do
      PronosticosDashboard::DB.setup
    end

    get '/' do
      haml :index
    end

    get '/api/days_status' do
      content_type :json
      Reports.days_status(settings.reporter_start_date, settings.reporter_end_date).to_json
    end

    get '/api/totals/monthly' do
      content_type :json
      Reports.monthly_totals().to_json
    end
  end
end

