# frozen_string_literal: true

require 'rubygems'
require 'sequel'

DB = Sequel.connect('sqlite://db/examples.db')
DB.create_table? :examples do
  primary_key :id
  String :name
  DateTime :started_at
  DateTime :finished_at
  Float :run_time
  String :status
  String :backtrace
  String :failure
  String :exception
  Integer :run_id
end

DB.create_table? :runs do
  primary_key :id
  DateTime :started_at
  DateTime :ended_at
  String :run_time
  String :success
end
