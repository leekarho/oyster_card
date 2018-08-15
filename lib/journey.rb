class Journey

  attr_reader :entry_station, :journey_list, :journey_arr

  def initialize
    @journey_list = {}
    @journey_arr = []
  end

  def start(station)
    @entry_station = station
    @journey_list[:entry] = @entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journey_list[:exit] = @exit_station
    puts @journey_arr << @journey_list
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def exit_station
    @exit_station
  end

  def fare
  end

end
