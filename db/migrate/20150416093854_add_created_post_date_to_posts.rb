class AddCreatedPostDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_date, :string
  end
end
