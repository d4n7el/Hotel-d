class ReservationsController < ApplicationController
	before_action :set_reservation, only: [:edit,:update,:destroy]
	before_action :authenticate_user!
	before_action :set_bedroom
	def index
		@bedrooms = Bedroom.includes(:cost).where(bedrooms: { state: "Activo" })
	end
	def new
		
	end
	def show

	end
	def create
		@reservation = current_user.reservations.build(reservation_params)
		@reservation.bedroom = @bedroom
		if @reservation.save
			redirect_to bedrooms_path
			flash[:notice] = "Se reservo la #{@bedroom.name}"
		end
	
	end
	def edit
		
	end
	def update
		
	end
	private 
	def reservation_params
		params.require(:reservation).permit(:bedroom_id,:client_name,:quantity_days,:identification_card,:phone,:admission_date,:departure_date)
	end
	def set_reservation
		@reservation = Reservation.find(params[:id])
	end
	def set_bedroom
		@bedroom = Bedroom.find(params[:bedroom_id])
		@reservation = Reservation.new()
	end
end
