class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone.to_i
  end


end