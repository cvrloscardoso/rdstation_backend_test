class CartsController < ApplicationController
  rescue_from ArgumentError, with: :handle_argument_error

  before_action :set_session

  def show
    render json: current_cart, serializer: CartSerializer
  end

  def create
    insert_products_in_cart

    render json: current_cart.reload, serializer: CartSerializer, status: :created
  end

  def add_item
    insert_products_in_cart

    render json: current_cart.reload, serializer: CartSerializer
  end

  def delete
    ::Products::CartRemover.perform(session[:cart_id], params[:product_id])

    render json: current_cart.reload, serializer: CartSerializer
  end

  private

  def set_session
    session[:cart_id] ||= current_cart.id
  end

  def insert_products_in_cart
    Products::CartInserter.perform(session[:cart_id], product_id, quantity)
  end

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || create_cart
  end

  def create_cart
    ::Carts::Creator.perform.cart
  end

  def product_id
    params.require(:product_id)
  end

  def quantity
    params.require(:quantity)
  end

  def handle_argument_error(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
