Rails.application.routes.draw do
  get 'sell/sale', to: 'listings#sale'
  get 'sell/index', to: 'listings#index'
  get 'sell/new', to: 'listings#new'
  get 'shop/', to:'listings#show_all'
  get  'sell/sold'

  get 'checkout/confirm', to:'checkout#confirm'
  get 'checkout/listings/:id', to:'checkout#pay', as: :checkout

  get 'addresses/new', to: 'addresses#new'

  get 'addresses/', to: 'addresses#show_all'
  # get 'listings/:id', to: 'items#show', as: :listing

  resources :listings
  root to:"home#index"
  devise_for :user

 
end
