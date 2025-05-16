RSpec.describe Carts::Creator do
  describe '.perform' do
    context 'happy path' do
      it 'creates a new cart' do
        expect { described_class.perform }.to change(Cart, :count).by(1)
      end
    end
  end
end
