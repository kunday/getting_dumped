# frozen_string_literal: true

Dir.mkdir('db') unless File.exist?('db')
# Use in-memory database for now.
DB = Sequel.sqlite
