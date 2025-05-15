class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  after_save :update_cart_total_price
  after_destroy :update_cart_total_price

  private

  def update_cart_total_price
    cart.update_total_price!
  end
end
