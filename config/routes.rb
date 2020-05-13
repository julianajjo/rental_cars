Rails.application.routes.draw do
  devise_for :users
    root to: 'home#index'
    resources :manufacturers
    resources :customers, only: [:index, :new, :create, :show] do
      get 'search', on: :collection
    end
    resources :subsidiaries, only: [:index, :new, :create, :show]
    resources :car_categories, only: %i[index new create show]
    resources :car_models, only: %i[index new create show]
    resources :rentals, only: [:index, :new, :create, :show] do
      get 'search', on: :collection
      get 'start', on: :member
      post 'start', on: :member, to: 'rentals#confirm'
    end
end
