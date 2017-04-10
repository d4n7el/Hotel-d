Rails.application.routes.draw do
  	

  get 'debts/index'
  get 'reservations/index'
  post 'reservations/:id/get_calendar', to: 'reservations#get_calendar', as: "reservation_calendar"
	resources :costs
	devise_for :users
	root 'home#index'
	resources :bedrooms do
		resources :reservations, except: [:index,:get_calendar]
		post '/reservations/:id/reservation_free', to: 'bedrooms#reservation_free', as: "reservation_free"
	end
	resources :reservations do
		resources :payments
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #post 'reservations/get_bedroom' , to: 'reservations#get_bedroom', as: "reserva"

end
