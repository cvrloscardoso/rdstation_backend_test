module Products
  class CartInserter
    include UseCase

    def initialize(cart_id, product_id, quantity)
      @cart_id = cart_id
      @product_id = product_id
      @quantity = quantity.to_i
    end

    def perform
      validate!

      return increase_product_quantity if product_already_in_cart?
      add_product_to_cart
    end

    private

    attr_reader :cart_id, :cart_product,  :product_id, :quantity

    def validate!
      raise ArgumentError, 'The quantity of the product must be greater than 0' if quantity < 1
      raise ArgumentError, 'This product does not exist' unless product
    end

    def product_already_in_cart?
      find_cart_product

      cart_product.present?
    end

    def increase_product_quantity
      cart_product.update!(quantity: cart_product.quantity + quantity)
    end

    def add_product_to_cart
      @cart_product ||= CartProduct.create!(cart_id: cart_id, product: product, quantity: quantity)
    end

    def find_cart_product
      @cart_product ||= CartProduct.find_by(cart_id: cart_id, product_id: product_id)
    end

    def product
      @product ||= Product.find_by(id: product_id)
    end
  end
end
