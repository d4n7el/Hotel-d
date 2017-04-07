class Reservation < ApplicationRecord
    belongs_to :bedroom
    belongs_to :user
    has_many :payments
    has_one :debt
    accepts_nested_attributes_for :payments
    accepts_nested_attributes_for :debt
    before_save :get_days
    after_create :set_income
    after_create :update_bedroom_reservation
    after_update :update_income
    scope :busqueda, ->(keyword){where("client_name LIKE ? OR identification_card LIKE ? ",keyword,keyword)}
    scope :orders, -> (orders){order("#{orders} Desc")}
    #---------------------------Private-------------------------
    private
        def obtener_imagen
            self.image || Image.new
        end
        def get_cover_url
            image.try(:cover_url) || "http://res.cloudinary.com/dboxtzegl/image/upload/v1488331135/photo_v0myys.png"
        end
        def update_bedroom_reservation
            if  self.state == "Activo"
                bedroom.update(reservation_id: self.id)
            end
        end
        def set_income
            pay = bedroom.cost.value.to_i * self.quantity_days.to_i
            #payments.create(value: pay, reason: "Reserva")
            self.create_debt(value: pay)
        end
        def update_income
            pay = bedroom.cost.value.to_i * self.quantity_days.to_i
            debt.update_attributes(value: pay)
        end
        def get_days
            if estado = Date.today.between?(self.admission_date.to_date,self.departure_date.to_date)
               self.state = "Activo"
            else
                self.state = "Pendiente"
            end
            difference_days =  self.departure_date.to_date - self.admission_date.to_date
            difference_days == 0 ? difference_days = 1 : difference_days
            self.quantity_days = difference_days
        end
end
