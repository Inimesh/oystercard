require 'oystercard'

describe Oystercard do
  describe '#balance' do
    context 'Oystercard initialized' do
      it 'will return an empty balance' do
        expect(subject.balance).to eq 0
      end

    end
    
    describe '#top_up' do
      context '@balance below balance limit' do
        it 'will add specified value to @balance' do
          value = rand(1..10)
          subject.top_up(value)
          expect(subject.balance).to eq value
        end
        
      end

      context '@balance above limit' do
        it 'will throw an error if final balance is above limit' do
          balance_limit = subject.balance_limit
          expect { subject.top_up(balance_limit + 1) }.to raise_error("balance exceeds limit of £#{balance_limit.to_s}")

        end
      end
    end
  end
end
