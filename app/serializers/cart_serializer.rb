class CartSerializer < ActiveModel::Serializer
  attributes :id, :total_price

  has_many :products, serializer: ProductSerializer

  def total_price
    object.total_price.to_f
  end
end
