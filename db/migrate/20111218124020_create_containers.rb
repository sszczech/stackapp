class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :group_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
