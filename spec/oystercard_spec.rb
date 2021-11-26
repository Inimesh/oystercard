require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do
  entry_zone = rand(1..6)
  exit_zone = rand(1..6)
  fare = (exit_zone - entry_zone).abs
  let(:entry_station) {  instance_double(Station, name: "Station 1", zone: entry_zone )  }
  let(:exit_station) {  instance_double(Station, name: "Station 2", zone: exit_zone )  }

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
      it 'sets @current_journey to an instance of the Journey class ' do
        subject.top_up(rand(1..10))
        subject.touch_in(entry_station)
        expect(subject.in_journey?).to eq true
      end

    end

    context '@balance < the minimum touch-in amount' do
      it '#touch_in will throw insufficient funds error' do

        expect { subject.touch_in(entry_station) }.to raise_error "insufficient funds to touch-in"
      end
    end
  end

  describe '#touch_out' do
    context '#in_journey? returns true' do
      it 'deducts the calculated fare' do
        subject.top_up(rand(1..10))
        subject.touch_in(entry_station)

        expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-fare)
      end
    end

    context '#in_journey? returns false' do
      it 'deducts the penalty fare' do
        expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-Journey::PENALTY_FARE)
      end
    end
  end

  describe '#in_journey?' do
    context 'card is not yet touched in' do
      it 'returns false' do
        expect(subject.in_journey?).to be false
      end
    end

    context 'card is touched in' do
      it 'returns true' do
        subject.top_up(rand(1..10))
        subject.touch_in(entry_station)

        expect(subject.in_journey?).to be true
      end
    end
  end

  describe '#add_journey' do
    context 'initialized Oystercard' do
      it '@journeys should be empty by default' do
        expect(subject.journeys.length).to eq 0
      end
    end

    context '@in_journey is set to true' do
      it 'adds a journey to @journeys' do
        subject.top_up(rand(1..10))
        expect {subject.touch_in(entry_station); subject.touch_out(exit_station) }.to change { subject.journeys.length }.by(1)
        
      end
    end
  end
end
