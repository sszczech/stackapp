class Container < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner, :class_name => 'User'
  validates :name, :presence => true

  default_scope order('created_at desc')

  attr_accessible :name, :attachments_attributes

  has_many :attachments, :dependent => :destroy, :as => :attachable
  accepts_nested_attributes_for :attachments
end
