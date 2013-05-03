unless File.exists?("db")
	Dir.mkdir('db')
end
# Use in-memory database for now.
DB = Sequel.sqlite
