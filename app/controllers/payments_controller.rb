class PaymentsController < ApplicationController
    def index
    end
    def new

    end
    def edit

    end
    def new

    end
    def create
        @reservation = Reservation.find(params[:reservation_id])
        @payment = Payment.new(payment_params)
        @payment.reservation = @reservation
        respond_to do |format|
            if @payment.save
                format.html { render html: @payment }
                format.js { render js: @payment }
                format.json { render json: @payment }
            else
                flash[:notice] = "Cantidad no valida"
            end
        end
    end
    #-----------------------------Private------------------------
    private
    def payment_params
        params.require(:payment).permit(:value,:reason)
    end
end
