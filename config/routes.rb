Rails.application.routes.draw do
  	

  get 'debts/index'

	resources :costs
	devise_for :users
	root 'home#index'
	resources :bedrooms do
		resources :reservations
		post '/reservations/:id/reservation_free', to: 'reservations#reservation_free', as: "reservation_free"
	end
	resources :reservations do
		resources :payments
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #post 'reservations/get_bedroom' , to: 'reservations#get_bedroom', as: "reserva"

end
