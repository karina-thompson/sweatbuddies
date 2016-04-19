class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :interests

  validates_uniqueness_of :email, message: 'Sorry an account with that email already exists'
  validates_presence_of :location
  validates_presence_of :user_name

  def compatible?(user)
    common_interests.length > 0
  end

  def common_interests(user)
    common = []
    interests.each do |interest|
      common << interest if user.interests.include? interest
    end
    common
  end

end