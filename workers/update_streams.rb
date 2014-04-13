require 'active_record'
require 'pg'
require 'models/video'
require 'robot'

def setup_database
  puts "Database connection details:#{params['database'].inspect}"
  return unless params['database']
  # estabilsh database connection
  ActiveRecord::Base.establish_connection(params['database'])
end

setup_database

Robot.scrape(params['sports'])
