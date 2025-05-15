RSpec.describe CartProduct, type: :model do
  subject { build(:cart_product) }

  describe 'relationships' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end
end
