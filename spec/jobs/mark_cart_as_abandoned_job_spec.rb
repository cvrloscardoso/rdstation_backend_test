RSpec.describe MarkCartAsAbandonedJob, type: :job do
  describe '#perform' do
    let(:non_abandonable_cart) { create(:cart) }
    let(:abandonable_cart1) { create(:cart, updated_at: 4.hours.ago) }
    let(:abandonable_cart2) { create(:cart, updated_at: 4.hours.ago) }

    subject(:perform_job) { described_class.new.perform }

    it 'mark abandonable carts as abandoned' do
      expect { perform_job }.to change { abandonable_cart1.reload.status }.from('active').to('abandoned')
        .and change { abandonable_cart2.reload.status }.from('active').to('abandoned')
        .and not_change { non_abandonable_cart.reload.status }
    end
  end
end
