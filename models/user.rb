class User < ActiveRecord::Base
  has_secure_password
  has_many :interest_users
  has_many :interests, through: :interest_users
end