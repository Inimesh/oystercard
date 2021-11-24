require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  
  subject { described_class.new(entry_station) }

  describe '#finish' do
    it 'sets @exit_station' do
      expect(subject.finish(exit_station)).to be_truthy
    end
  end
end