Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users, controllers: { registrations: "registrations" }

  as :user do
    get '/signup', to: 'devise/registrations#new'
  end

  root 'static_pages#home'
  get  '/help',   to: 'static_pages#help'
  get  '/about',  to: 'static_pages#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
