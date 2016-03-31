require "spec_helper"
require "./lib/money"

RSpec.describe Money do
  let(:exchange_service) { double("exchange", exchange_rate: 1)}
  it "is equal to itself" do
    expect(Money.new("20", Money::GBP, exchange_service)).to eq(Money.new("20", Money::GBP, exchange_service))
  end

  it "is equal to a sum of the same amount" do
    expect(Money.new("10", Money::GBP, exchange_service) + Money.new("10", Money::GBP, exchange_service)).to eq(Money.new("20", Money::GBP, exchange_service))
  end

  it "is equal to a different amount" do
    expect(Money.new("10", Money::GBP, exchange_service) + Money.new("10", Money::GBP, exchange_service)).to_not eq(Money.new("10", Money::GBP, exchange_service))
  end

  it "is equal to another amount in a different currency of the same converted value" do
    allow(exchange_service).to receive(:exchange_rate).with(Money::GBP, Money::USD).and_return(1.5)
    expect(Money.new("20", Money::GBP, exchange_service)).to eq(Money.new("30", Money::USD, exchange_service))
  end
end
