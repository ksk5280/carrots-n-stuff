class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items
  enum drone: %w(unrequested pending rejected completed)

  validates :status,
            presence: true,
            inclusion: {
              in: %w(ordered paid cancelled completed),
              message: "%{value} is not a valid status"
            }

  def formatted_creation_date
    created_at.strftime("%B %-d, %Y")
  end

  def formatted_update_date
    updated_at.strftime("%B %-d, %Y")
  end

  def formatted_creation_time
    created_at.localtime.strftime("%-l:%M %p")
  end

  def formatted_update_time
    updated_at.localtime.strftime("%-l:%M %p")
  end

  def total
    line_items.sum(:subtotal)
  end

  def self.status_total(status)
    where(status: status).count
  end

  def self.statuses
    %w(ordered paid cancelled completed)
  end
end
