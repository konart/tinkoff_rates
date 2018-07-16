# Визуализация курсов валют

Tinkoff API: https://www.tinkoff.ru/api/v1/currency_rates/

Для визуализации используется

https://www.chartkick.com/

В качестве планировщика заданий для ежечасной закачки данных выступает

https://github.com/plashchynski/crono

Использование:

`bundle exec crono RAILS_ENV=development`

или как демон:

`gem 'daemons'`

`bundle install; bundle exec crono start RAILS_ENV=development`

Seeds содержат набор рандомизированных данных за последние 24 часа

