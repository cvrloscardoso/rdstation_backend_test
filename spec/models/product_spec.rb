RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe 'relationships' do
    it { is_expected.to have_many(:cart_products) }
    it { is_expected.to have_many(:carts).through(:cart_products) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
