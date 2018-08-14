class Oystercard
  attr_reader :balance, :entry_station

  MAX_LIMIT = 90
  MIN_CHARGE = 1

  def initialize (balance = 0)
    @balance = balance
  end

  def add_money(money)
    raise "max limit of #{MAX_LIMIT} reached" if @balance >= MAX_LIMIT
    @balance += money
  end

  def touch_in(station)
    raise "not enough funds. please top-up" if @balance < MIN_CHARGE
    @entry_station = station
  end

  def touch_out
    puts deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(money)
    @balance -= money
  end

end
