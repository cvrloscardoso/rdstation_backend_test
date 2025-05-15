class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products

  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
