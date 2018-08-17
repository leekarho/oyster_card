class Journey

  MIN_CHARGE = 1
  PEN_CHARGE = 6

  def start(station)
    @entry_station = station
  end

  def finish(exit_st)
    @exit_station = exit_st
  end

  def fare
    @entry_station == nil || @exit_station == nil ? PEN_CHARGE : MIN_CHARGE
  end
end
