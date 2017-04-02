class AddDefaultToBedrooms < ActiveRecord::Migration[5.0]
  def change
  	remove_column :bedrooms, :state, :string
  	add_column :bedrooms, :state, :string, default: "Activo"
  end
end
