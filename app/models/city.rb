class City < ActiveRecord::Base
  has_many :trips
  has_many :users, through: :trips

  validates :name, :presence => true
end
