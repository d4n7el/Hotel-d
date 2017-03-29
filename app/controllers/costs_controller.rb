class CostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cost, only: [:edit,:update,:destroy]
  def index
  	@costs = Cost.all
  end
  def new
  	@cost = Cost.new
  end
  def create
  	@cost = Cost.new(cost_params)
  	if @cost.save
  		redirect_to costs_path
      flash[:notice] = 'se realizo el registro existosamente.'
  	end
  end
  def edit
    
  end
  def update
    if @cost.update(cost_params)
      redirect_to costs_path
      flash[:notice] = ' La actualización fue existosa '
    end
  end

  #-------------------------------------------------------------------------------------------------
  private

  def cost_params
  	params.require(:cost).permit(:type_service,:value,:category,:description,
      image_attributes:[:cover,:id])
  end
  def set_cost
    @cost = Cost.find(params[:id])
  end
end
