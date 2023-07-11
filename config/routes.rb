Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :owners
  post '/owner/login', to: 'owners#login'

  resources :customers
  post '/customer/login', to: 'customers#login'

  resources :hotells
  get '/see', to: 'hotells#my_hotels'
  get '/search_by_location', to: 'hotells#search_hotel'
  get '/search_hotel_by_name', to: 'hotells#search_hotel_by_name'
  get '/search_hotel_with_room', to: 'hotells#see_hotel_with_room'

  post '/room/create', to: 'rooms#create'

  get '/open_hotel', to: 'customers#open_hotel'
  get '/cust/search_hotel_by_name', to: 'customers#search_hotel_by_name'
  get '/cust/search_a_hotel_with_rooms', to: 'customers#search_a_hotel_with_rooms'
  get '/cust/see_bookings', to: 'customers#see_bookings'
  get '/cust/filter_bookings_by_location', to: 'customers#filter_bookings_by_location'
  get '/cust/show_booking', to: 'customers#show_booking'
  get '/cust/particular_booking_details', to: 'customers#particular_booking_details'

  post '/book/create', to: 'bookings#create'
end
