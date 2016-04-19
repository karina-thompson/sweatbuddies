require 'pry'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './models/user'
require './models/interest'
require './models/interest_user'


binding.pry