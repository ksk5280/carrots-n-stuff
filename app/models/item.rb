class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  belongs_to :store

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :categories, presence: true
  has_attached_file :image,
    default_url: "default.png",
    path: ":url",
    url: "/:filename"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.all_for_active_stores
    joins(:store).merge(Store.all_active)
  end
end
