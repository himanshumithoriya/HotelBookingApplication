Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :locations

  # resources :users

  resources :owners
  post '/user/login', to: 'users#login'

  resource :customers
  get '/customer/index', to: 'customers#index'

  resources :hotells
  get '/search_by_location', to: 'hotells#search_hotel_by_location'
  get '/search_hotel_by_name', to: 'hotells#search_hotel_by_name'
  

  post '/room/create', to: 'rooms#create'
  get '/room/list', to: 'rooms#room_list_by_hotell_id'

  get '/open_hotel', to: 'customers#open_hotel'
  get '/cust/search_hotel_by_name', to: 'customers#search_hotel_by_name'
  
  
 
  resources :bookings
  get '/book/filter_bookings_by_location', to: 'bookings#filter_bookings_by_location'
   
end
