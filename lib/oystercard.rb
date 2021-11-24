
class Oystercard
  attr_reader :balance, :balance_limit
  
  BALANCE_LIMIT = 90
  MIN_TOUCH_IN_AMOUNT = 1

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
    # TODO: for some reason it is printing out '£' character in irb as '\xC2\xA3'
    raise "balance exceeds limit of £#{BALANCE_LIMIT}" if @balance + value > BALANCE_LIMIT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    raise "insufficient funds to touch-in" if @balance < MIN_TOUCH_IN_AMOUNT
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