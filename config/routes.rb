Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users, controllers: { registrations: "registrations" }

  as :user do
    get '/signup',    to: 'registrations#new'
    post '/signup',   to: 'registrations#create'
    get '/login',     to: 'devise/sessions#new'
    post '/login',    to: 'devise/sessions#create'
    delete '/logout', to: 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show] do
    member do
      get :added_friends, :friend_requests
    end
  end
  resources :posts,       only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]
  resources :comments,    only: [:create, :destroy]
  resources :profiles,    only: [:edit, :update]

  get '/help',   to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
