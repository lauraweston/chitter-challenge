require "sinatra/base"

class ChitterApp < Sinatra::Base

  get "/" do

  end

  run! if app_file == $0
end
