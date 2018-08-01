class RemoveLengthOfVisitFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :length_of_visit, :string
  end
end
