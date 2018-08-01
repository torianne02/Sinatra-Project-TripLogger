class User < ActiveRecord::Base
  has_secure_password

  has_many :trips
  has_many :cities, through: :trips

  validates :username, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true
end
