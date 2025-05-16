class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity, :unit_price, :total_price

  def quantity
    object.cart_products.last&.quantity
  end

  def unit_price
    object.price.to_f
  end

  def total_price
    return (object.price * quantity).to_f if quantity
  end
end
