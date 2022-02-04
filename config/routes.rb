Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create" 
  get "password/reset/edit", to: "password_resets#edit"
  post "password/reset/edit", to: "password_resets#update" 

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"
  # Defines the root path route ("/")
  # root "tweets#index"
  root "tweets#index"

  resources :tweets do
    member do
      post 'add_like'
      get 'likes'
    end
  end

  resources :users do
    member do
      get 'followers'
    end
  end

end
