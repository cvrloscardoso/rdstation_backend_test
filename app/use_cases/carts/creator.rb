module Carts
  class Creator
    include UseCase

    attr_reader :cart

    def initialize; end

    def perform
      create_cart
    end

    private

    def create_cart
      @cart = Cart.create!
    end
  end
end
