class AddPostableTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postable_type, :string
  end
end
