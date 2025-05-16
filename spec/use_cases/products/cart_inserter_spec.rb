RSpec.describe Products::CartInserter do
  describe '.perform' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:quantity) { 1 }

    subject(:class_perform) { described_class.perform(cart.id, product.id, quantity) }

    context 'when the quantity of product is less than 1' do
      let(:quantity) { 0 }

      it 'raises an error' do
        expect { class_perform }.to raise_error(ArgumentError, 'The quantity of the product must be greater than 0')
      end
    end

    context 'when the product does not exist' do
      let(:product) { double(id: nil) }

      it 'raises an error' do
        expect { class_perform }.to raise_error(ArgumentError, 'This product does not exist')
      end
    end

    context 'when product already is in the cart' do
      let!(:cart_product) { create(:cart_product, cart: cart, product: product) }

      it 'updates the quantity of the existing item in the cart and not change countage from cart_products' do
        expect { class_perform }.to change { cart_product.reload.quantity }.by(quantity)
          .and not_change(CartProduct, :count)
      end
    end

    context 'when product does not exist in the cart' do
      let(:last_cart_product) { CartProduct.last }

      it 'creates a new cart_product with relation between cart and product' do
        expect { class_perform }.to change(CartProduct, :count).by(1)
        expect(last_cart_product.cart_id).to eq(cart.id)
        expect(last_cart_product.product_id).to eq(product.id)
      end
    end
  end
end
