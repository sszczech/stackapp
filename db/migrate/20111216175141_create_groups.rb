class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :teacher_id
      t.string :name

      t.timestamps
    end
  end
end
