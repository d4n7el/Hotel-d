class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.references :reservation, foreign_key: true
      t.string :value
      t.string :reason

      t.timestamps
    end
  end
end
