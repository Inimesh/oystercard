require 'journey'

describe Journey do
  let(:exit_station) { double :exit_station }
  let(:entry_station) { double :entry_station }
  penalty_fare = Journey::PENALTY_FARE
  
  
  describe '#finish' do
    it 'sets @exit_station' do
      expect(subject.finish(exit_station)).to be_truthy
    end
  end
  
  describe '#calc_fare' do
    context 'there is a valid entry and exit station' do
      it 'calculates and returns non-penalty fare' do
        # TODO entry_station double when passed to as an argument (below)
        # evaluates to nil??
        subject { described_class.new(entry_station) }
        subject.finish(exit_station)
        expect(subject.calc_fare).to eq 1
      end
    end

    context 'there is an exit station but no entry station' do
      it 'returns the penalty fare' do
        subject.finish(exit_station)

        expect(subject.calc_fare).to eq penalty_fare
      end
    end

    context 'there is an entry station but no exit station' do
      it 'returns the penalty fare' do
        subject { described_class.new(entry_station) }
        subject.finish()
        
        expect(subject.calc_fare).to eq penalty_fare
      end
    end
  end
end