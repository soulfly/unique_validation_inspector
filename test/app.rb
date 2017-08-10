# https://stackoverflow.com/questions/18543155/testing-a-gem-that-uses-activerecord-models
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/schema.rb'
require File.dirname(__FILE__) + '/models.rb'
