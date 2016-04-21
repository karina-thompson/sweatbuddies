class Event < ActiveRecord::Base
 belongs_to :interest
 belongs_to :user

 validates_presence_of :name
 validates_presence_of :interest_id
 validates_presence_of :date_time
end
