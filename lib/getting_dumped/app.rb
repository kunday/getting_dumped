# frozen_string_literal: true

require 'getting_dumped'
require 'sinatra'

class GettingDumpedServer < Sinatra::Application
  get '/runs' do
    @runs = DB[:runs]
    erb :runs
  end

  get '/run/:id' do
    @examples = DB[:examples].where(run_id: params[:id]).all
    erb :examples
  end
end

GettingDumpedServer.run!
