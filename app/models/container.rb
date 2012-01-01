class Container < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner, :class_name => 'User'
  validates :name, :presence => true

  default_scope order('created_at desc')

  attr_accessible :name
end
