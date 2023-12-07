Rails.application.routes.draw do
  # resources :guest_lists
  # resources :menus
  # resources :wishlists
  # resources :funds
  # resources :guest_books
  # resources :photos
  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "static_pages#home"

  resources :locations
  resources :events

  # # Users show routes:
  # resources :users do
  #   resources :guest_list, only: [:show, :update]
  #   resources :menu, only: [:show, :update]
  #   resources :wishlist, only: [:show, :update]
  #   resources :photos, only: [:index, :show]
  #   resources :guest_book, only: [:show, :update]
  #   resources :fund, only: [:show, :update]
  # end
end