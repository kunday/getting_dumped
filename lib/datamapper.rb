require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3:db/examples.sqlite3")
  #                {
  #   :database => 'db/examples.sqlite3',
  #   :adapter => 'sqlite3'
  # })

class Example
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :run_time, String

  belongs_to :run
end

class Run
  include DataMapper::Resource

  property :id, Serial
  property :run_at, DateTime
  property :duration, String

  has n, :examples
end

DataMapper.finalize
DataMapper.auto_upgrade!
