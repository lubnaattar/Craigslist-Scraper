class AddRatingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rating, :integer
    add_column :posts, :isDuplicate, :integer
    add_column :posts, :mileage, :string
    add_column :posts, :transmission, :string
    add_column :posts, :account_id, :string
    add_column :posts, :source_map_google, :string
  end
end
