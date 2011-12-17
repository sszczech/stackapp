class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :description
      t.string :content_type
      t.integer :size
      t.string :attachable_type
      t.integer :attachable_id

      t.timestamps
    end
  end
end
