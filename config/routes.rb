Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "flats#index"
  resources :flats
  # resources :user, only: [:create, :new, :destroy, :show, :edit, :update]
end
