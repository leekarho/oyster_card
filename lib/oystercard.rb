class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize (balance = 0)
    @balance = balance
  end

  def add_money(money)
    raise "max limit of #{MAX_LIMIT} reached" if @balance >= MAX_LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    true
  end

  def touch_out
    false
  end

  def in_journey?
    true
  end


end
