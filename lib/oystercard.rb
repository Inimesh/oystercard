
class Oystercard
  attr_reader :balance, :balance_limit, :entry_station, :journeys
  
  BALANCE_LIMIT = 90
  MIN_TOUCH_IN_AMOUNT = 1
  MINIMUM_FARE = 2.80

  def initialize(balance=0)
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(value)
    # TODO: for some reason it is printing out '£' character in irb as '\xC2\xA3'
    raise "balance exceeds limit of £#{BALANCE_LIMIT}" if @balance + value > BALANCE_LIMIT
    @balance += value
  end

  
  def touch_in(entry_station)
    raise "insufficient funds to touch-in" if @balance < MIN_TOUCH_IN_AMOUNT
    @in_journey = true
    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    add_journey(@entry_station, exit_station)
    @entry_station = nil
    @in_journey = false
    deduct(MINIMUM_FARE)
  end
  
  # Getter methods:
  def in_journey?
    !!@entry_station
  end



  private
  def deduct(value)
    @balance -= value
  end

  def add_journey(entry_station, exit_station)
    @journeys << {in: entry_station, out: exit_station}
  end
end