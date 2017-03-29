Rails.application.routes.draw do
  	

	resources :costs
	devise_for :users
	root 'home#index'
	
	resources :bedrooms do
		resources :reservations
		#post 'reservations/get_bedroom' , to: 'reservations#get_bedroom', as: "reserva"
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
