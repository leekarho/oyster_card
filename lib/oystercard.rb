require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :journey

  MAX_LIMIT = 90
  MIN_CHARGE = 1

  def initialize (balance = 0, journey_log = Journey_log.new)
    @balance = balance
    @journey_log = journey_log
  end

  def add_money(money)
    raise "max limit of #{MAX_LIMIT} reached" if @balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station = nil)
    raise "not enough funds. please top-up" if @balance < MIN_CHARGE
    @journey_log.start(station)
  end

  def touch_out(exit_st = nil)
    @journey_log.finish(exit_st)
    deduct(@journey_log.fare)
  end

  private

  def deduct(money)
    @balance -= money
  end

end
