class BedroomsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_bedroom, only: [:edit,:update,:destroy]
	before_action :updte_state_reservation, only: [:index]
	before_action :update_state, only:[:reservation_free]
	def index
		#@Bedrooms = Bedroom.where(state: "Activo")
		@bedrooms= params[:state_reservation] == "Activo" ? 
			Bedroom.includes(:cost).where.not(bedrooms: { reservation_id: nil }).includes(:reservations).where(reservations: {state: "Activo"}) :
		@bedrooms= params[:state_reservation] == "Libre" ? 
			Bedroom.includes(:cost).where(bedrooms: { reservation_id: nil, state: "Activo" }) :
		@bedrooms = params[:state_bedroom].present? ? 
			Bedroom.includes(:cost).where(bedrooms: { state: params[:state_bedroom]}) :
		@bedrooms = Bedroom.includes(:cost).includes(:reservations).includes(:reservations)
		@bedrooms_out = Reservation.where('departure_date LIKE ?',"#{Date.today}%").where(state: "Activo" ).count
	end
	def show
		@reservation = Reservation.new
	end
	def edit
		@costs = Cost.where(category: "habitacion")
	end
	def new
		@bedroom = Bedroom.new
		@costs = Cost.where(category: "habitacion")
	end
	def create
		@bedroom = Bedroom.new(bedroom_params)
		if @bedroom.save
			redirect_to bedrooms_path
			flash[:notice] = 'se realizo el registro existosamente.'
		end
	end
	def update
		if @bedroom.update(bedroom_params)
			redirect_to bedrooms_path
			flash[:notice] = 'se realizo la actualización existosamente.'
		end
	end
	def reservation_free
		@reservation = @bedroom.reservations(params[:id])
	 	@reservation.update_all( state: "Finalizado" )
		@bedroom.update(reservation_id: '')
		@debt.update(state: "Pago")
		redirect_to bedrooms_path
		flash[:notice] = "Se Libero la  reserva de la #{@bedroom.name}"
	end
	#----------------------------------------------------Private---------------------
	private
	def update_state
		@reservation = Reservation.find(params[:id])
		@bedroom = Bedroom.find(@reservation.bedroom_id)
		@debt = Debt.where(reservation_id: params[:id])
	end
	def bedroom_params
		params.require(:bedroom).permit(:cost_id,:name,:state,
			image_attributes:[:cover,:id])
	end
	def set_bedroom
		@bedroom = Bedroom.find(params[:id])
	end
	def updte_state_reservation
		reservations = Reservation.where(state: "Pendiente")
		reservations.each do |r|
			if estado = Date.today.between?(r.admission_date.to_date,r.departure_date.to_date)
               Bedroom.find(r.bedroom_id).update(reservation_id: r.id)
               r.update(state: "Activo")
            end
		end
		reservations = Reservation.where(state: "Activo")
		reservations.each do |r|
			unless estado = Date.today.between?(r.admission_date.to_date,r.departure_date.to_date)
               Bedroom.find(r.bedroom_id).update(reservation_id: r.id)
               r.update(state: "Finalizado")
            end
		end
	end
end
