Rails.application.routes.draw do
  resources :listings do
    collection do
      get :departments
      get :categories
      get :subcategories
      get :sizes
    end
  end

  resources :bank_accounts do
  end  
  
  resources :users,  only: [:show, :edit, :update]
  root to:"home#index"
  devise_for :user
  

  get 'sell/sale', to: 'listings#sale'
  get 'sell/index', to: 'listings#index'
  get 'sell/new', to: 'listings#new'
  get 'shop/', to:'listings#show_all'
  get 'shop/:department', to:'listings#show_all', as: :shop_department
  get  'sell/sold', to:'listings#sold'

  get 'order/confirm/:id', to:'order#confirm'
  get 'order/listings/:id', to:'order#pay', as: :checkout

  
  # get 'order/addresses', to: 'addresses#index' , as: :addresses

  # post 'order/addresses', to: 'addresses#create'

  # get 'order/addresses/new', to:'addresses#new', as: :new_address

  # get 'order/listing/addresses/:id', to:'addresses#listing_index', as: :listing_addresses
  # resources :addresses do
    
  # end

  get 'addresses', to:'addresses#index', as: :addresses

  post 'addresses', to: 'addresses#create'

  get 'addresses/new', to:'addresses#new', as: :new_address

  get 'addresses/:id', to:'addresses#listing_index', as: :listing_addresses



  

  get 'order/fulfill/order/:id', to: 'order#fulfill', as: :fulfill

  get 'order/details/:id', to: 'order#details', as: :order_details

  get 'order/purchase/details/:id', to: 'order#purchase_details', as: :order_purchase_details

  get 'user/purchases', to: 'listings#purchases', as: :purchases

  get 'home/sell', to:'home#sell'

  get '/:username', to: 'listings#storefront', as: :storefront



  # get 'addresses/', to: 'addresses#show'

  # get 'addresses/put', to: 'addresses#put'
  # get 'listings/:id', to: 'items#show', as: :listing

  
  

 
end
