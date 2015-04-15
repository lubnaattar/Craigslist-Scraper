class AddFuelToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :fuel_vehicle, :string
  end
end
