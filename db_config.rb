require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'activitybuddies'
}

ActiveRecord::Base.establish_connection(options)

