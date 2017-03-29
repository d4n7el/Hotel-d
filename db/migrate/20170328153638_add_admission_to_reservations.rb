class AddAdmissionToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :admission_date, :datetime
    add_column :reservations, :departure_date, :datetime
    add_column :reservations, :state, :string,  default: "Activo"
  end
end
