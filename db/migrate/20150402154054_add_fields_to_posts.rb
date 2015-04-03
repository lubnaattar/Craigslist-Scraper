class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :year, :string
    add_column :posts, :phone, :string
    add_column :posts, :state, :string
    add_column :posts, :city, :string
    add_column :posts, :zipcode, :string
    add_column :posts, :paint_color, :string
    add_column :posts, :drive, :string
   
  end
end
