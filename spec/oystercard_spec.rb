require 'oystercard'

describe Oystercard do
  context 'Oystercard initialized' do
    describe '#balance' do
      it 'will return an empty balance' do
        expect(subject.balance).to eq 0
      end


    end
    
  end
end
