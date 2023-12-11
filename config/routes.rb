Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "static_pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :locations
  
  resources :events
  resources :events do
    get 'add_location', on: :member
    post 'create_association', on: :member
    post 'join_as_guest', on: :member
    get 'join_as_guest', on: :member

    resources :albums do
      get 'event_album', on: :member
        resources :images
    end

  end
  
  # Static pages
  post "about", to: "static_pages#about"
  post "contact", to: "static_pages#contact"
  post "feedback", to: "static_pages#feedback"
  post "terms", to: "static_pages#terms"
  post "privacy", to: "static_pages#privacy"
  post "faq", to: "static_pages#faq"
  
  # # Users show routes:
  resources :users do
    resources :avatars, only: [:create] #ajout de photo de profil

  

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
  post "up" => "rails/health#show", :as => :rails_health_check
end
