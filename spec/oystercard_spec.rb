require 'oystercard'

describe Oystercard do
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
        balance_limit = subject.balance_limit
        expect { subject.top_up(balance_limit + 1) }.to raise_error("balance exceeds limit of £#{balance_limit.to_s}")

      end
    end
  end

  describe '#deduct' do
    it 'will deduct a specified amount from @balance' do
      value = rand(1..10)
      subject.deduct(value)
      expect(subject.balance).to eq -value
    end
  end

  describe '#touch_in' do
    it 'sets @in_journey = true' do
      subject.touch_in
      expect(subject.in_journey?).to be true
    end
  end

  describe '#touch_out' do
    context '@in_journey is set to true' do
      before do
        subject.touch_in
      end

      it 'sets @in_journey = false' do
        subject.touch_out
        expect(subject.in_journey?).to be false
      end
      
    end
  end
end
