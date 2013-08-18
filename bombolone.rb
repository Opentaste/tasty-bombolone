# bombolone.rb
require 'rubygems'
require 'sinatra/base'
require 'cassandra'

class Helpers < Sinatra::Base
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

class LoginScreen < Sinatra::Base
  enable :sessions

  get('/login') do
  	content = {
  		:foo => "bar"
  	}
  	erb :login, :locals => content
  end

  post('/login') do
    if params[:name] == 'admin' && params[:password] == 'admin'
      session['user_name'] = params[:name]
    else
      redirect '/login'
    end
  end
end

class MyApp < Sinatra::Base
  # middleware will run before filters
  use Helpers
  use LoginScreen

  before do
    # ~~~~
  end

  get('/') do
  	@test_word = "leo"
  	erb :index
  end

  get '/*' do
    erb :not_found
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
