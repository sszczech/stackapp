class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :author, :class_name => 'User'

  validates :content, :presence => true

  default_scope order('created_at desc')
end
