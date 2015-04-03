class AddFlaggedStatusToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :flagged_status, :integer
  end
end
