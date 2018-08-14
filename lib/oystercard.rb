class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_CHARGE = 1

  def initialize (balance = 0)
    @balance = balance
    @in_journey = false
  end

  def add_money(money)
    raise "max limit of #{MAX_LIMIT} reached" if @balance >= MAX_LIMIT
    @balance += money
  end

  def touch_in
    raise "not enough funds. please top-up" if @balance < MIN_CHARGE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_CHARGE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(money)
    @balance -= money
  end

end
