RSpec.describe Products::CartRemover do
  describe '.perform' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    subject(:class_perform) { described_class.perform(cart.id, product.id) }

    context 'when the product does not exist in the cart' do
      it 'raises an error' do
        expect { class_perform }.to raise_error(ArgumentError, 'The product does not exist in the cart!')
      end
    end

    context 'when the product exists in the cart' do
      let!(:cart_product) { create(:cart_product, cart: cart, product: product) }

      it 'removes the product from the cart and destroy relation between cart and product' do
        expect { class_perform }.to change(CartProduct, :count).by(-1)
        expect(cart.cart_products).to be_empty
        expect(product.cart_products).to be_empty
      end
    end
  end
end
