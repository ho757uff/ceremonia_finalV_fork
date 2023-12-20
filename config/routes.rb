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
    get 'guest_list', on: :member
    post 'add_guest', on: :member
    get 'remove_guest', on: :member
    delete 'remove_guest', on: :member
    
    resources :albums do            #créer les routes CRUD pour les albums. Les albums sont imbriqués dans un event
      resources :images do          # est imbriqué à l'intérieur d'un album. Ce sont les routes spécifiques à un album. Ce qui permet de manipuler les images pour un album spécifique
        resources :comments         # est imbriqué à l'intérieur d'une image. Pour manipuler les commentaires pour une image spécifique
      end
    end                             # on gère de manière hiérarchique
  end

  # Static pages
  get "about", to: "static_pages#about"
  # get "contact", to: "static_pages#contact"
  # get "feedback", to: "static_pages#feedback"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"
  get "faq", to: "static_pages#faq"
  get "experience", to: "static_pages#experience"

  # # Users show routes:
  resources :users do
    resources :avatars, only: [:create] # ajout de photo de profil

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
