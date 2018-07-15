require 'net/http'
require 'json'

# Класс Api реализует методы обращения к api банка и реализует метод perform,
# необходимый для crono (https://github.com/plashchynski/crono)
class Api
  attr_accessor :endpoint

  def initialize(url = nil)
    @endpoint =  url || 'https://www.tinkoff.ru/api/v1/currency_rates/'
  end

  def perform
    data = request_data
    rates = prepare data
    save rates
  end

  private

  def request_data
    uri = URI(@endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')

    response = http.request(request)
    response.body
  end

  def prepare(data)
    json = JSON.parse data
    return [] unless json.dig('payload', 'rates')
    json['payload']['rates'].select { |r| r['category'] == 'DepositPayments' }
  end

  def save(rates)
    rates.each do |r|
      from = r.dig('fromCurrency', 'name')
      to = r.dig('toCurrency', 'name')
      buy = r['buy']
      sell = r['sell']
      next if [from, to, buy, sell].any?(&:nil?)
      Rate.create(from: from, to: to, buy: buy.to_f, sell: sell.to_f)
    end
  end
end
