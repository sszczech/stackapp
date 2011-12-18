class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :group_id
      t.integer :leader_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
