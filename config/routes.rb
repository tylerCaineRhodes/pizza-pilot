Rails.application.routes.draw do
  root "toppings#index"
  resources :toppings
end
