class AddAuthorIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :author_id, :integer
  end
end
