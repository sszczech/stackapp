class AddAccessToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :access, :string
  end
end
