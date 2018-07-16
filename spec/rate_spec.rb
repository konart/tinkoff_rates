require 'rspec'

describe Rate, type: :model do
  subject(:rate) { described_class.new }
  sell = 62.35
  buy = 60.9
  time = Time.now
  before :each do
    described_class.create('created_at' => time, 'from' => 'USD', 'to' => 'RUB', 'sell' => sell, 'buy' => buy)
  end

  it 'should return a hash of time-value pairs' do
    expect(rate.get_pair_by_action('USD', 'RUB', :sell)).to eq ({time => sell})
    expect(rate.get_pair_by_action('USD', 'RUB', :buy)).to eq ({time => buy})
  end

  it 'should return a hash of pair-average pairs' do
    expect(rate.avg_pairs).to eq ({%w[USD RUB] => {sell: sell, buy: buy}})
  end
end