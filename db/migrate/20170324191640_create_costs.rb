class CreateCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :costs do |t|
      t.string :type_service
      t.integer :value
      t.string :category
      t.string :description

      t.timestamps
    end
  end
end
