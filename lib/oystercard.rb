require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :journeys
  
  BALANCE_LIMIT = 90
  MIN_TOUCH_IN_AMOUNT = 1

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
  
  def in_journey?
    !!@current_journey
  end

  private
  def deduct(value)
    @balance -= value
  end

  def add_journey(journey)
    @journeys << {
      in_station: !!journey.entry_station ? {name: journey.entry_station.name, zone: journey.entry_station.zone} : nil, 
      out_station: !!journey.exit_station ? {name: journey.exit_station.name, zone: journey.exit_station.zone} : nil,
      fare: journey.calc_fare
    }
    @current_journey = nil
  end
end