class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station=nil)

    @entry_station = entry_station
    @exit_station = nil

  end

  def finish(exit_station=nil)
    @exit_station = exit_station
  end

  def calc_fare
    complete?() ? 1 : PENALTY_FARE
  end

  def complete?()
    @entry_station != nil && @exit_station != nil
  end
end