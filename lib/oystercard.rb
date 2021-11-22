
class Oystercard
  attr_reader :balance, :balance_limit

  def initialize(balance=0)
    @balance = balance
    @balance_limit = 90
  end

  def top_up(value)
    # TODO: for some reason is printing out '£' character as '\xC2\xA3'
    raise "balance exceeds limit of £#{@balance_limit}" if @balance + value > @balance_limit
    @balance += value
  end
end