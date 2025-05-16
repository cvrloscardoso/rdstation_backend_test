RSpec.describe ProductSerializer do
  describe '#as_json' do
    let(:cart_product) { create(:cart_product) }
    let(:product) { cart_product.product }
    let(:serialized_product) { described_class.new(product).as_json }

    subject { described_class.new(product).as_json }

    it do
      is_expected.to eq({
        id: product.id,
        name: product.name,
        quantity: cart_product.quantity,
        unit_price: product.price.to_f,
        total_price: (product.price * cart_product.quantity).to_f
      })
    end
  end
end
