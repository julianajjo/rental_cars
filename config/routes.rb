Rails.application.routes.draw do
  devise_for :users
    root to: 'home#index'
    resources :manufacturers
    resources :car_categories, only: %i[new create show]
    resources :car_models, only: %i[index new create show]
    resources :rentals, only: [:index, :new, :create]
end
