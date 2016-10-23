ENV["RACK_ENV"] ||= "development"

require "sinatra/base"
require_relative "datamapper_setup"

class ChitterApp < Sinatra::Base
  enable :sessions
  set :session_secret, "super_secret"

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get "/" do
    @peeps = Peep.all
    erb :index
  end

  get "/users/new" do
    if params[:duplicate_user]
      @error = "Username or email is already taken. Try an alternative."
    end
    erb :"users/new_user"
  end

  post "/users" do
    @user = User.create(name: params[:name],
                        user_name: params[:user_name],
                        email: params[:email],
                        password: params[:password])
    if @user.id.nil?
      redirect to "/users/new?duplicate_user=true"
    else
      session[:user_id] = @user.id
      redirect to "/"
    end
  end

  get "/peeps/new" do
    erb :"peeps/new_peep"
  end

  post "/peeps" do
    @peep = Peep.create(message: params[:message])
    redirect to "/"
  end

  run! if app_file == $0
end
