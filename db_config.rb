require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'activitybuddies'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)

