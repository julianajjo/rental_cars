Rails.application.routes.draw do
  devise_for :users
    root to: 'home#index'
    resources :manufacturers
    resources :subsidiaries, only: [:index, :new, :create, :show]
    resources :car_categories, only: %i[index new create show]
    resources :car_models, only: %i[index new create show]
    resources :rentals, only: [:index, :new, :create] do
      get 'search', on: :collection
    end
end
