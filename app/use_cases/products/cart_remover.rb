module Products
  class CartRemover
    include UseCase

    def initialize(cart_id, product_id)
      @cart_id = cart_id
      @product_id = product_id
    end

    def perform
      validate!

      remove_product_from_cart!
    end

    private

    attr_reader :cart_id, :product_id

    def validate!
      raise ArgumentError, 'The product does not exist in the cart!' unless cart_product
    end

    def remove_product_from_cart!
      cart_product.destroy!
    end

    def product
      @product = cart_product.product
    end

    def cart_product
      @cart_product ||= CartProduct.find_by(cart_id: cart_id, product_id: product_id)
    end
  end
end
