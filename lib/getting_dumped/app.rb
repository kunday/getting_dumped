require "getting_dumped"
require "sinatra"

set :run, true

get '/runs' do
  @runs = Run.all
  erb :runs
end

get '/run/:id' do
  @examples = Run.find(params[:id]).first.examples
  erb :examples
end