class Run
  include DataMapper::Resource

  property :id, Serial
  property :run_at, DateTime
  property :duration, String

  has n, :examples
end
