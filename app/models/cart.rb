class Cart < ApplicationRecord
  STATUS = %w[active abandoned].freeze

  has_many :cart_products
  has_many :products, through: :cart_products

  validates_numericality_of :total_price, greater_than_or_equal_to: 0
  validates_inclusion_of :status, in: STATUS

  def mark_as_abandoned!
    update!(status: 'abandoned')
  end

  def update_total_price!
    total_price = cart_products.joins(:product).sum('products.price * cart_products.quantity')

    update!(total_price: total_price)
  end
end
