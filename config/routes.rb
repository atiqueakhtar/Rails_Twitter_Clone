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

  resources :tweets

  resources :users

  post "like", to: "tweets#handle_like"
  get "like", to: "tweets#show_likes"

  get "my_tweets", to: "tweets#my_tweets"
  get "other_tweets", to: "tweets#other_tweets"
  get "archived_tweets", to: "tweets#archived_tweets"
end
