class ReservationsController < ApplicationController
	before_action :set_reservation, only: [:edit,:update,:destroy]
	before_action :authenticate_user!
	before_action :new_reservation, only: [:new,:create]
	def index
		keyword = params[:keyword].present? ? "%#{params[:keyword]}%" :  "%"
		order = params[:order].present? ? params[:order] : "bedroom_id"
		@reservation = params[:keyword].present? || params[:order].present? ? 
			 Reservation.includes(:bedroom).busqueda(keyword).orders(order) :
		@reservation = params[:filter_card].present? ? Reservation.includes(:bedroom).where(reservations: {identification_card: params[:filter_card] }).orders(order) :
		@reservation = params[:filter_state].present? ? Reservation.includes(:bedroom).where(reservations: {state: params[:filter_state]}).orders(order) :
		@reservation = params[:filter_bedroom].present? ? Reservation.includes(:bedroom).where(bedrooms: {name: params[:filter_bedroom]}).orders(order) :
		@reservation = params[:reservations_out].present? ? Reservation.where('departure_date LIKE ?',"#{Date.today}%").where(reservations: {state: "Activo"}).includes(:bedroom).includes(:debt) :
		@reservation = Reservation.includes(:bedroom)
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
			redirect_to edit_bedroom_reservation_path(@bedroom,@reservation)
			flash[:notice] = "Se Actualizo reserva de la #{@bedroom.name}"
		end
	end
	def get_calendar
        @calendar =  Reservation.where(bedroom_id: params[:id]).where.not(state: "Finalizado")
        respond_to do |format|
            format.html { render html: @calendar }
            format.js { render js: @calendar }
            format.json { render json: @calendar}
        end
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
