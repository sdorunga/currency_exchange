class Money
  GBP = :gbp
  USD = :usd

  def self.gbp(amount)
    new(amount, GBP, ExchangeRate.new)
  end

  def self.usd(amount)
    new(amount, USD, ExchangeRate.new)
  end

  def initialize(amount, currency, conversion_service)
    @amount = amount.to_i * 100
    @currency = currency
    @conversion_service = conversion_service
  end

  def ==(other)
    self.amount == converted_amount(other)
  end

  def +(other)
    Money.new((self.amount + converted_amount(other))/100, currency, @conversion_service)
  end

  def to_s
    amount / 100.0
  end

  protected
  attr_reader :amount, :currency

  def converted_amount(other)
    other.amount / @conversion_service.exchange_rate(self.currency, other.currency)
  end
end

class ExchangeRate
  def exchange_rate(from, to)
    return 1 if from == to
    1.4
  end
end
