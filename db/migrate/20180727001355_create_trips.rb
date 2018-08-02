class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.integer :city_id
      t.string :length_of_visit
      t.timestamps null: false
    end
  end
end
