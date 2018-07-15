require 'rspec'

describe Rate, type: :model do
  subject(:rate) { described_class.new }
  value = 60.9
  time = Time.now
  before :each do
    described_class.create('created_at' => time, 'from' => 'USD', 'to' => 'RUB', 'sell' => value, 'buy' => 62.35)
  end

  it 'should return a hash of time-value pairs' do
    # prepare data
    # value = 60.9
    # time = Time.now
    # described_class.create('created_at' => time, 'from' => 'USD', 'to' => 'RUB', 'sell' => value, 'buy' => 62.35)
    expect(rate.get_pair_by_action('USD', 'RUB', :sell)).to eq ({time => value})
  end

  it 'should return a hash of pair-average pairs' do
    # value = 60.9
    # time = Time.now
    # described_class.create('created_at' => time, 'from' => 'USD', 'to' => 'RUB', 'sell' => value, 'buy' => 62.35)
    expect(rate.avg_pairs).to eq ({})
  end
end