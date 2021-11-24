require 'oystercard'

describe Oystercard do
  let(:station) { double :entry_station }

  describe '#balance' do
    context 'Oystercard initialized' do
      it 'will return the balance' do
        expect(subject.balance).to eq subject.balance
      end

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
        balance_limit = Oystercard::BALANCE_LIMIT
        expect { subject.top_up(balance_limit + 1) }.to raise_error("balance exceeds limit of £#{balance_limit.to_s}")

      end
    end
  end

  describe '#touch_in' do
    context '@balance is >= minimum touch-in amount' do
      before do
        subject.top_up(rand(1..10))
      end

      it 'sets @in_journey = true' do
        subject.touch_in(station)
        expect(subject.in_journey?).to be true
      end

      it 'stores the empty station' do
        subject.touch_in(station)
        expect(subject.entry_station).not_to be_nil
      end
    end

    context '@balance < the minimum touch-in amount' do
      it '#touch_in will throw insufficient funds error' do

        expect { subject.touch_in(station) }.to raise_error "insufficient funds to touch-in"
      end
    end
  end

  describe '#touch_out' do
    context '@in_journey is set to true' do
      before do
        subject.top_up(rand(1..10))
        subject.touch_in(station)
      end

      it 'sets @in_journey = false' do
        subject.touch_out
        expect(subject.in_journey?).to be false
      end

      it 'deducts the minimum fare' do
        minimum_fare = Oystercard::MINIMUM_FARE
        expect { subject.touch_out }.to change(subject, :balance).by(-minimum_fare)
      end
    end
  end

  describe '#in_journey?' do
    it 'returns @in_journey' do
      expect(subject.in_journey?).to be false
    end
  end
end
