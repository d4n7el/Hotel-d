class CreateBedrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :bedrooms do |t|
      t.references :cost, foreign_key: true
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
