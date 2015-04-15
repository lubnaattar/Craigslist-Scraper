class AddMoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :model_vehicle, :string
    add_column :posts, :make_vehicle, :string
    add_column :posts, :type_vehicle, :string
    add_column :posts, :title_status, :string
  end
end
