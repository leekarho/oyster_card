require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey

  MAX_LIMIT = 90
  MIN_CHARGE = 1

  def initialize (balance = 0, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def add_money(money)
    raise "max limit of #{MAX_LIMIT} reached" if @balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station = nil)
    raise "not enough funds. please top-up" if @balance < MIN_CHARGE
    @journey.start(station)
  end

  def touch_out(exit_station = nil)
    @journey.finish(exit_station)
    puts deduct(MIN_CHARGE)
  end

  private

  def deduct(money)
    @balance -= money
  end

end
