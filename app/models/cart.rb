class Cart < ApplicationRecord
  STATUS = %w[active abandoned].freeze

  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: STATUS }

  scope :abandonable, -> { where('updated_at <= ?', 3.hours.ago).where('status = ?', 'active') }
  scope :abandoned_for_seven_days_or_more, -> { where('updated_at <= ?', 7.days.ago).where('status = ?', 'abandoned') }

  def update_total_price!
    total_price = cart_products.joins(:product).sum('products.price * cart_products.quantity')

    update!(total_price: total_price)
  end
end
