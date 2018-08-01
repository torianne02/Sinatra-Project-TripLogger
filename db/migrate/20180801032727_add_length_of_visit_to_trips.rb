class AddLengthOfVisitToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :length_of_visit, :string
  end
end
