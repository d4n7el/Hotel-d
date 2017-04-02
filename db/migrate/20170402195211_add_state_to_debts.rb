class AddStateToDebts < ActiveRecord::Migration[5.0]
  def change
    add_column :debts, :state, :string, default: "Pendiente"
  end
end
