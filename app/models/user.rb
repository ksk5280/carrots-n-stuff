class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  belongs_to :store
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  enum status: %w(Pending Hired Fired)

  def fullname
    "#{first_name} #{last_name}"
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end
end
