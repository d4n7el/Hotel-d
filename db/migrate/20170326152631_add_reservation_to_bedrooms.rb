class AddReservationToBedrooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :bedrooms, :reservation, foreign_key: true, default: "0"
  end
end
