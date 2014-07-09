require 'sinatra'

module PronosticosDashboard
  class WebApp < Sinatra::Base

    # TODO: user absolute path
    set :root, File.expand_path('.')

    get '/' do
      haml :index
    end

    get '/api/days_status' do
      content_type :json
      Reports.days_status.to_json
    end
  end
end

