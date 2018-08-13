class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize (balance = 0)
    @balance = balance
  end

  def add_money(money)
    raise 'max limit reached' if @balance >= MAX_LIMIT
    @balance += money
  end
end
