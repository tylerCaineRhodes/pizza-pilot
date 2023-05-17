Rails.application.routes.draw do
  root "pizzas#index"

  resources :pizzas do
    resources :pizza_toppings
  end

  resources :toppings
end
