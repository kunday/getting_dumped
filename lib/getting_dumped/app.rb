require "sinatra"
require "models"

get '/runs' do
  @runs = Run.all
  erb :runs
end
