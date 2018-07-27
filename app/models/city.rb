class City < ActiveRecord::Base
  has_many :users, through: :trips 
end
