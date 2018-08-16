class Journey

  attr_reader :entry_station, :journey_list, :journey_arr, :exit_station

  MIN_CHARGE = 1
  PEN_CHARGE = 6

  def initialize
    @journey_list = { entry: [], exit: [] }
  end

  def start(station)
    @in_journey = true
    @entry_station = station
    @journey_list[:entry] << @entry_station
  end

  def finish(exit_st)
    @in_journey = false
    @exit_station = exit_st
    @journey_list[:exit] << @exit_station
  end

  def in_journey?
    @in_journey
  end

  def fare
    @entry_station == nil || @exit_station == nil ? PEN_CHARGE : MIN_CHARGE
  end
end
