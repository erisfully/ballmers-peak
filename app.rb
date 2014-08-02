require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack-flash'
require 'sinatra/reloader'
require 'sinatra/partial'
require 'JSON'
require 'open-uri'

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


  class Gifs
    def gif_info
      JSON.parse(open("http://api.gifme.io/v1/search?query=beer&limit=10&page=0&key=rX7kbMzkGu7WJwvG").read)
    end

  end

  get "/" do
    erb :index
  end

get "/beer" do
    gifs = Gifs.new.gif_info
    erb :beer, locals: {gifs: gifs}
  end

end