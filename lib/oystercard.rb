class Oystercard
  attr_reader :balance

  def initialize
    @balance = 25
  end

  def add_money(money)
    @balance += money
  end
end
