class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.string :content
      t.string :commentable_type
      t.integer :commentable_id

      t.timestamps
    end
  end
end
