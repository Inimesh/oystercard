require_relative './station.rb'

class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station=nil)

    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station=nil)
    @exit_station = exit_station
    return self
  end

  def calc_fare
    complete?() ? (@entry_station.zone - @exit_station.zone).abs : PENALTY_FARE
    
  end

  def complete?()
    !!@entry_station && !!@exit_station
  end
end