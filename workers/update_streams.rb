require 'active_record'
require 'pg'
require 'models/video'

ActiveRecord::Base.establish_connection(params['database'])

Video.update(params['sports'])
