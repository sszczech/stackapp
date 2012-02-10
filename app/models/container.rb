class Container < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner, :class_name => 'User'
  validates :name, :presence => true
  validates :access, :inclusion => { :in => ['public', 'private'] }

  default_scope order('created_at desc')

  attr_accessible :name, :attachments_attributes, :access

  has_many :attachments, :dependent => :destroy, :as => :attachable
  accepts_nested_attributes_for :attachments

  def public?
    self.access == 'public'
  end

  def private?
    self.access == 'private'
  end

  def has_access?(user)
    public? || private? && [owner, group.teacher].include?(user)
  end
end
