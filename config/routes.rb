Rails.application.routes.draw do
  get 'rates/index'
  resources :rates, :path => '/'

  get 'rates/show/:from/:to/:act', to: 'rates#show', as: 'rate_show'
  get 'rates/show_avg/:from/:to/:act', to: 'rates#show_avg', as: 'rate_show_average'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
