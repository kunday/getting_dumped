require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3:db/examples.sqlite3")

class Example
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :started_at, DateTime
  property :finished_at, DateTime
  property :run_time, Float
  property :status, String
  property :backtrace, Text
  property :failure, String
  property :exception, Text

  belongs_to :run
end

class Run
  include DataMapper::Resource

  property :id, Serial
  property :started_at, DateTime
  property :ended_at, DateTime
  property :run_time, String
  property :success, String

  has n, :examples
end

DataMapper.finalize
DataMapper.auto_upgrade!
