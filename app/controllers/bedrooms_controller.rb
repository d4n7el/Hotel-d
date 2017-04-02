class BedroomsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_bedroom, only: [:edit,:update,:destroy]
	def index
		#@Bedrooms = Bedroom.where(state: "Activo")
		@bedrooms= params[:state_reservation] == "Activo" ? 
			Bedroom.includes(:cost).where.not(bedrooms: { reservation_id: params[:state_reservation] }).includes(:reservations).where(reservations: {state: "Activo"}) :
		@bedrooms= params[:state_reservation] == "Libre" ? 
			Bedroom.includes(:cost).where(bedrooms: { reservation_id: nil, state: "Activo" }) :
		@bedrooms = params[:state_bedroom].present? ? 
			Bedroom.includes(:cost).where(bedrooms: { state: params[:state_bedroom]}) :
		@bedrooms = Bedroom.includes(:cost).where(bedrooms: { state: "Activo"})
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
	#----------------------------------------------------Private---------------------
	private
	def bedroom_params
		params.require(:bedroom).permit(:cost_id,:name,:state,
			image_attributes:[:cover,:id])
	end
	def set_bedroom
		@bedroom = Bedroom.find(params[:id])
	end
end
