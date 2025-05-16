RSpec.describe RemoveAbandonedCartsJob, type: :job do
  describe '#perform' do
    let(:non_deletable_cart1) { create(:cart, :abandoned, updated_at: 6.days.ago) }
    let(:non_deletable_cart2) { create(:cart, :abandoned) }
    let(:non_deletable_cart3) { create(:cart, updated_at: 7.days.ago) }
    let(:deletable_cart1) { create(:cart, :abandoned, updated_at: 8.days.ago) }
    let(:deletable_cart2) { create(:cart, :abandoned, updated_at: 8.days.ago) }

    subject(:perfom_job) { described_class.new.perform }

    around do |example|
      CartProduct.skip_callback(:save, :after, :update_cart_total_price)
      example.run
      CartProduct.set_callback(:save, :after, :update_cart_total_price)
    end

    before do
      create(:cart_product, cart: deletable_cart1)
      create(:cart_product, cart: deletable_cart2)
    end

    it 'remove abandoned carts with more than 7 days of inactivity' do
      expect { described_class.new.perform }.to change(Cart, :count).by(-2)
        .and not_change { non_deletable_cart1 }
        .and not_change { non_deletable_cart2 }
        .and not_change { non_deletable_cart3 }
    end
  end
end
