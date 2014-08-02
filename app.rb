require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack-flash'
require 'sinatra/reloader'
require 'sinatra/partial'
require 'twitter'

# include all .rb files in models directory
Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }

class App < Sinatra::Application

  #initial application settings
  set :root, File.dirname(__FILE__)
  enable :sessions
  use Rack::Flash
  register Sinatra::ActiveRecordExtension

  #using sinatra-partials gem with settings
  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :partial_underscores

  #use reloader in development
  configure :development do
    register Sinatra::Reloader
  end



  get "/" do
    erb :index
  end

  get "http://api.gifme.io/v1/search?query=r/:beer&limit=1&page=0&key=rX7kbMzkGu7WJwvG" do
    beer = "beer"
    erb :beer, :locals => {beer: beer}
  end



end