require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :journeys
  
  BALANCE_LIMIT = 90
  MIN_TOUCH_IN_AMOUNT = 1
  MINIMUM_FARE = 2.80

  def initialize(balance=0)
    @balance = balance
    @journeys = []
    @current_journey = nil
  end

  def top_up(value)
    # TODO: for some reason it is printing out '£' character in irb as '\xC2\xA3'
    raise "balance exceeds limit of £#{BALANCE_LIMIT}" if @balance + value > BALANCE_LIMIT
    @balance += value
  end

  
  def touch_in(entry_station)
    raise "insufficient funds to touch-in" if @balance < MIN_TOUCH_IN_AMOUNT
    @current_journey = Journey.new(entry_station)

  end
  
  def touch_out(exit_station)
    finished_journey = in_journey?() ? @current_journey : Journey.new()

    finished_journey.finish(exit_station)
    deduct(finished_journey.calc_fare)
    add_journey(finished_journey)

  end
  
  # Getter methods:
  def in_journey?
    !!@current_journey
  end

  private
  def deduct(value)
    @balance -= value
  end

  def add_journey(journey)
    @journeys << {in: journey.entry_station, out: journey.exit_station}
    @current_journey = nil
  end
end