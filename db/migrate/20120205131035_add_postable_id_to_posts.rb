class AddPostableIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postable_id, :integer
  end
end
