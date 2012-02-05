class Post < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  belongs_to :group
  belongs_to :author, :class_name => 'User'

  validates :content, :presence => true

  default_scope order('created_at desc')

  has_many :comments, :dependent => :destroy, :as => :commentable
  has_many :attachments, :dependent => :destroy, :as => :attachable
  accepts_nested_attributes_for :attachments

  attr_accessible :content, :comments_attributes, :attachments_attributes
end
