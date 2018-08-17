class Journey

  attr_reader :entry_station, :journey_list, :journey_arr, :exit_station

  MIN_CHARGE = 1
  PEN_CHARGE = 6

  def fare(entry_station, exit_station)
    @entry_station == nil || @exit_station == nil ? PEN_CHARGE : MIN_CHARGE
  end
end
