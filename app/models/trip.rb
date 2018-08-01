class Trip < ActiveRecord::Base
  belongs_to :city
  belongs_to :user

  validates :length_of_visit, :presence => true
end
