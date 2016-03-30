class Store < ActiveRecord::Base
  has_many :items, dependent: :destroy
  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  enum status: %w(pending suspended approved)

  def generate_slug
    self.slug = name.parameterize if name
  end

  def self.all_active
    where(status: 2)
  end
end
