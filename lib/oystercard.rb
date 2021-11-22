
class Oystercard
  attr_reader :balance, :balance_limit

  def initialize(balance=0)
    @balance = balance
    @balance_limit = 90
    @in_journey = false
    @min_touch_in_amount = 1
  end

  def top_up(value)
    # TODO: for some reason it is printing out '£' character in irb as '\xC2\xA3'
    raise "balance exceeds limit of £#{@balance_limit}" if @balance + value > @balance_limit
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    raise "insufficient funds to touch-in" if @balance < @min_touch_in_amount
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  # Getter methods:
  def in_journey?
    @in_journey
  end
end