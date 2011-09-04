require "getting_dumped"
require "sinatra"

class GettingDumpedServer < Sinatra::Application
  get '/runs' do
    @runs = Run.all
    erb :runs
  end

  get '/run/:id' do
    @examples = Run.find(params[:id]).first.examples
    erb :examples
  end
end

GettingDumpedServer.run!
