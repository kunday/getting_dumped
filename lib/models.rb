require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, {
    :database => 'db/examples.sqlite3',
    :adapter => 'sqlite3'
  })

class Run
  include DataMapper::Resource

  property :id, Serial
  property :run_at, DateTime
  property :duration, String

  has n, :examples
end

class Example
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :run_time, String

  belongs_to :run
end

DataMapper.finalize
DataMapper.auto_upgrade!
