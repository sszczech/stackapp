class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => 'User'

  validates :content, :presence => true

  attr_accessible :content
end
