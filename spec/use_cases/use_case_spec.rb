RSpec.describe UseCase do
  class DummyUseCase
    include UseCase
  end

  describe '.perform' do
    let(:instance) { double('DummyUseCase') }

    it 'instantiates the use case and calls perform' do
      expect(DummyUseCase).to receive(:new).and_return(instance)
      expect(instance).to receive(:perform)

      DummyUseCase.perform
    end
  end

  describe '#perform' do
    let(:use_case) { DummyUseCase.new }

    it 'raises NotImplementedError' do
      expect { use_case.perform }.to raise_error(NotImplementedError)
    end
  end
end
