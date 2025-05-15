RSpec.describe Cart, type: :model do
  subject { build(:cart) }

  describe 'relationships' do
    it { is_expected.to have_many(:cart_products) }
    it { is_expected.to have_many(:products).through(:cart_products) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Cart::STATUS) }
  end

  describe '#update_total_price!' do
    let(:cart) { create(:cart) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }

    around do |example|
      CartProduct.skip_callback(:save, :after, :update_cart_total_price)
      example.run
      CartProduct.set_callback(:save, :after, :update_cart_total_price)
    end

    before do
      create(:cart_product, cart: cart, product: product1)
      create(:cart_product, cart: cart, product: product2)
    end

    it 'updates the total price of the cart with correct values' do
      expect { cart.update_total_price! }.to change { cart.total_price }.from(0).to(product1.price + product2.price)
    end
  end
end
