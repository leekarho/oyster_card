
class Journey_log

  attr_reader :entry_station, :journey_list, :journey_arr, :exit_station

  def initialize(journey_klass = Journey.new)
    @journey = journey_klass
    @journey_arr = []
    @in_journey = nil
  end

  def start(station)
    @in_journey = true
    @entry_station = station
    @journey.start(station)
  end

  def finish(exit_st)
    @in_journey = false
    @exit_station = exit_st
    @journey_arr << { entry: @entry_station, exit: @exit_station }
    @journey.finish(exit_st)
  end

  def in_journey?
    @in_journey
  end

  def fare
    @journey.fare
  end
end
