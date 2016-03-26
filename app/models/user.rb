class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :stores
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  enum role: %w(user admin)
  def fullname
    "#{first_name} #{last_name}"
  end
end
