class User < ActiveRecord::Base
  # extend Slugifiable::ClassMethods
  # include Slugifiable::InstanceMethods
  has_secure_password

  has_many :trips
  has_many :cities, through: :trips
end
