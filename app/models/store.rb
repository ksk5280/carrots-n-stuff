class Store < ActiveRecord::Base
  has_many :items
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
