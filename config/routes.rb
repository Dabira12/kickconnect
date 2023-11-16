Rails.application.routes.draw do
  get 'sell/sale', to: 'listings#sale'
  get 'sell/index', to: 'listings#index'
  get 'sell/new', to: 'listings#new'
  get 'shop/', to:'listings#show_all'
  get  'sell/sold'

  get 'checkout/confirm', to:'checkout#confirm'
  get 'checkout/listings/:id', to:'checkout#pay', as: :checkout

  get '/:username', to: 'listings#storefront'

  # get 'addresses/new', to: 'addresses#new'

  # get 'addresses/', to: 'addresses#show'

  # get 'addresses/put', to: 'addresses#put'
  # get 'listings/:id', to: 'items#show', as: :listing

  resources :addresses do
    
  end

  resources :listings do
    collection do
      get :departments
      get :categories
      get :subcategories
      get :sizes
    end
  end
  resources :users,  only: [:show, :edit, :update]
  root to:"home#index"
  devise_for :user

 
end
