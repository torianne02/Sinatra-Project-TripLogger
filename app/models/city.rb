class City < ActiveRecord::Base
  # extend Slugifiable::ClassMethods
  # include Slugifiable::InstanceMethods

  has_many :trips
  has_many :users, through: :trips
end
