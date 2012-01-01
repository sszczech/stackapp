class Team < ActiveRecord::Base
  belongs_to :group
  belongs_to :leader, :class_name => 'User'

  validates :name, :presence => true

  has_many :team_users, :dependent => :destroy
  has_many :users, :through => :team_users

  attr_accessible :name, :description, :user_ids

  def to_param
    [id, name.parameterize].join('-')
  end
end
