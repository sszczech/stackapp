class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, UserPhotoUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :photo, :email, :password, :password_confirmation, :remember_me, :remove_photo

  has_many :user_groups, :dependent => :destroy
  has_many :groups, :through => :user_groups

  def activities
    Stream.find(id)
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def name
    "#{first_name} #{last_name}"
  end
end
