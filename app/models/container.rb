class Container < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner, :class_name => 'User'
  validates :name, :presence => true
end
