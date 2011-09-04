class Example
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :run_time, String

  belongs_to :run
end
