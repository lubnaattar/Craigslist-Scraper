class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :level
      t.string :code
      t.string :shortName
      t.string :longName

      t.timestamps
    end
  end
end
