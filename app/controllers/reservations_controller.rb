class ReservationsController < ApplicationController
	before_action :set_reservation, only: [:edit,:update,:destroy,:reservation_free]
	before_action :authenticate_user!
	before_action :new_reservation, only: [:new,:create]
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
			redirect_to edit_bedroom_reservation_path(@bedroom,@reservation)
			flash[:notice] = "Se reservo la #{@bedroom.name}"
		end
	
	end
	def edit
		
	end
	def update
		if @reservation.update(reservation_params)
			redirect_to bedrooms_path
			flash[:notice] = "Se Actualizo reserva de la #{@bedroom.name}"
		end
	end
	def reservation_free
		@reservation.update(state: 'Finalizado')
		@bedroom.update(reservation_id: '')
		@debt.update(state: "Pago")
		redirect_to bedrooms_path
		flash[:notice] = "Se Libero la  reserva de la #{@bedroom.name}"
	end
	private 
	def reservation_params
		params.require(:reservation).permit(:bedroom_id,:client_name,:quantity_days,:identification_card,:phone,
			:admission_date,:departure_date)
	end
	def set_reservation	
		@payment = Payment.new()
		@payments = Payment.where(reservation_id: params[:id])
		@debt = Debt.where(reservation_id: params[:id])
		@reservation = Reservation.where(bedroom_id: params[:bedroom_id]).find(params[:id])
		@bedroom = Bedroom.find(params[:bedroom_id])
	end
	def new_reservation
		@bedroom = Bedroom.find(params[:bedroom_id])
		@reservation = Reservation.new()
		@debt = Debt.new()
	end
end
