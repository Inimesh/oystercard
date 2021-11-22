require 'oystercard'

describe Oystercard do
  context 'Oystercard initialized' do
    describe '#balance' do
      it 'will return an empty balance' do
        expect(subject.balance).to eq 0
      end

    end
    
    describe '#top_up' do
      it 'will add specified value to @balance' do
        value = rand(1..10)
        subject.top_up(value)
        expect(subject.balance).to eq value
      end
    end
  end
end
