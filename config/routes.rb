Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "static_pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  resources :locations
  resources :events
  resources :events do
    post 'join_as_guest', on: :member
    get 'join_as_guest', on: :member
  end

  # Static pages
  get "about", to: "static_pages#about"
  get "contact", to: "static_pages#contact"
  get "feedback", to: "static_pages#feedback"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"
  get "faq", to: "static_pages#faq"

  # # Users show routes:
  resources :users do
    #   resources :guest_list, only: [:show, :update]
    #   resources :menu, only: [:show, :update]
    #   resources :wishlist, only: [:show, :update]
    #   resources :photos, only: [:index, :show]
    #   resources :guest_book, only: [:show, :update]
    #   resources :fund, only: [:show, :update]
  end
  # resources :guest_lists
  # resources :menus
  # resources :wishlists
  # resources :funds
  # resources :guest_books
  # resources :photos
end
