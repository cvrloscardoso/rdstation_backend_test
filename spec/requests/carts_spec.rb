RSpec.describe "/cart", type: :request do
  describe "GET /show" do
    include_context 'session double'

    let(:cart) { create(:cart) }
    let!(:cart_product1) { create(:cart_product, cart: cart) }
    let!(:cart_product2) { create(:cart_product, cart: cart) }
    let(:serialized_response) { CartSerializer.new(cart).to_json }

    subject(:request) { get '/cart' }

    before { session_hash[:cart_id] = cart.id }

    it 'returns information about the cart' do
      request

      expect(response).to be_ok
      expect(response.body).to eq(serialized_response)
    end
  end

  describe "POST /cart" do
    include_context 'session double'

    let(:product) { create(:product) }
    let(:serialized_response) { CartSerializer.new(product.cart_products.last.cart).to_json }

    context 'when does not have a created cart' do
      subject(:request) { post '/cart', params: { product_id: product.id, quantity: 1 } }

      it 'creates new cart and cart_product to insert product' do
        allow(Products::CartInserter).to receive(:perform).and_call_original

        expect { request }.to change(Cart, :count).by(1).and change(CartProduct, :count).by(1)
        expect(response).to be_created
        expect(response.body).to eq(serialized_response)
      end
    end
  end

  describe "POST /add_item" do
    include_context 'session double'

    let(:cart_product) { create(:cart_product) }
    let(:session_hash) { { } }
    let(:serialized_response) { CartSerializer.new(cart_product.cart).to_json }

    context 'when the product already is in the cart' do
      subject(:request) { post '/cart/add_item', params: { product_id: cart_product.product_id, quantity: 1 } }

      before { session_hash[:cart_id] = cart_product.cart_id }

      it 'updates the quantity of the existing item in the cart' do
        allow(Products::CartInserter).to receive(:perform).and_call_original

        expect { request }.to change { cart_product.reload.quantity }.by(1)
        expect(response).to be_ok
        expect(response.body).to eq(serialized_response)
      end
    end
  end

  describe "DELETE /cart/:product_id" do
    include_context 'session double'

    let(:cart) { create(:cart) }
    let(:cart_product) { create(:cart_product, cart: cart) }
    let!(:cart_product2) { create(:cart_product, cart: cart) }
    let(:product_id) { cart_product.product_id }
    let(:session_hash) { { } }
    let(:serialized_response) { CartSerializer.new(cart.reload).to_json }

    context 'when the product already is in the cart and should be removed' do
      subject(:request) { delete "/cart/#{cart_product.product_id}" }

      before { session_hash[:cart_id] = cart.id }

      it 'updates the quantity of the existing item in the cart' do
        allow(Products::CartRemover).to receive(:perform).and_call_original

        request

        expect(cart.cart_products.where(product_id: product_id)).to be_empty
        expect(response).to be_ok
        expect(response.body).to eq(serialized_response)
      end
    end
  end
end
