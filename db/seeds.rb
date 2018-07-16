# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
time = 1.day.ago
rng = Random.new

24.times do |_|
  time += 1.hour
  sell = rng.rand(62.0...65.0)
  buy = rng.rand(60.0...63.0)
  Rate.create(from: 'USD', to: 'RUB', sell: sell, buy: buy, created_at: time)
  sell = rng.rand(82.0...85.0)
  buy = rng.rand(80.0...83.0)
  Rate.create(from: 'EUR', to: 'RUB', sell: sell, buy: buy, created_at: time)
end