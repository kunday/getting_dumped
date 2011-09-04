require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, {
    :database => 'db/examples.sqlite3',
    :adapter => 'sqlite3'
  })

DataMapper.finalize
DataMapper.auto_upgrade!
