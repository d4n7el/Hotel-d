class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :reservation, foreign_key: true
      t.integer :value
      t.string :reason

      t.timestamps
    end
  end
end
