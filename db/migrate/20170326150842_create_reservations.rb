class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :bedroom, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity_days
      t.string :client_name
      t.string :identification_card
      t.string :phone

      t.timestamps
    end
  end
end
