RSpec.describe CartSerializer do
  describe '#as_json' do
    let(:cart_product) { create(:cart_product) }
    let(:cart) { cart_product.cart }
    let(:product) { cart_product.product }
    let(:serialized_product) { ProductSerializer.new(product).as_json }

    subject { described_class.new(cart).as_json }

    it do
      is_expected.to eq({
        id: cart.id,
        total_price: cart.total_price.to_f,
        products: Array.wrap(serialized_product)
      })
    end
  end
end
