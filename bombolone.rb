# bombolone.rb
require 'rubygems'
require 'sinatra/base'
require 'sinatra/content_for'
require 'cassandra'
#require 'simple_uuid'

db = Cassandra.new('Bombolone')

begin
  user = db.get(:Users, 'admin')
  print user
rescue
  print "\nCassandra Error : Missed the Keyspace Name Bombolone, \n"
  print "go to check the Cassandra cofiguration in the README.md\n"
end

class MainScreen < Sinatra::Base
  # Main Pages
  helpers Sinatra::ContentFor
  enable :sessions

  get('/') do
    @test_word = "leo"
    erb :home
  end
end


class LoginScreen < Sinatra::Base
  # Login Pages
  helpers Sinatra::ContentFor
  enable :sessions

  get('/login') do
  	erb :login
  end

  post('/login') do
    if params[:name] == 'admin' && params[:password] == 'admin'
      session['user_name'] = params[:name]
    else
      redirect '/admin'
    end
  end
end


# Admin Pages
class AdminScreen < Sinatra::Base
  helpers Sinatra::ContentFor
  enable :sessions

  get('/admin') do
    erb :admin
  end
end


class Helpers < Sinatra::Base
  # Helpers functions
  include Rack::Utils
  alias_method :h, :escape_html

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [@username, @password]
  end
end


class TastyBombolone < Sinatra::Base
  # Main Bombolone App

  before do
    # ~~~~
  end

  # Middleware will run before
  use Helpers
  use MainScreen
  use LoginScreen
  use AdminScreen

  get '/*' do
    erb :not_found
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
