Rails.application.routes.draw do
  devise_for :users

  root "groups#index"

  resources :groups, only: [:index, :new, :show, :create, :destroy] do
    resources :entities, only: [:index, :new, :show, :create, :destroy]
  end

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
