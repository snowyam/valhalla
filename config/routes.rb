Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users, controllers: { registrations: "registrations" }

  as :user do
    get '/signup',    to: 'devise/registrations#new'
    post '/signup',   to: 'devise/registrations#create'
    get '/login',     to: 'devise/sessions#new'
    post '/login',    to: 'devise/sessions#create'
    delete '/logout', to: 'devise/sessions#destroy'
  end

  get '/help',   to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
