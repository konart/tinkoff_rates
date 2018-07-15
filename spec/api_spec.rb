require 'rails_helper'
require 'tinkoff/tinkoff'


describe 'Api' do

  subject(:api) { Api.new }

  it 'should get response body' do
    expect(api.send(:request_data)).not_to eq ''
  end

  it 'should parse data for exchange rates' do
    data = api.send(:request_data)
    expect(api.send(:prepare, data).empty?).not_to eq true
  end

  it 'should save rates to database' do
    keys = %w[fromCurrency toCurrency buy sell]
    values = [{'name' => 'USD'}, {'name' => 'RUB'}, 60.9, 62.35]
    rates = [Hash[keys.zip values]]
    api.send(:save, rates)
    values = values.map { |e| e.is_a?(Hash) ? e['name'] : e }
    expect(Rate.last.attributes.values_at('from', 'to', 'buy', 'sell')).to eq values
  end

end