class User < ActiveRecord::Base
  has_secure_password
  has_many :interest_users
  has_many :interests, through: :interest_users

  validates_uniqueness_of :email, message: 'Sorry an account with that email already exists'
  validates_presence_of :location
  validates_presence_of :user_name
end