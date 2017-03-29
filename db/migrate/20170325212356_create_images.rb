class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :cover
      t.references :bedroom, foreign_key: true
      t.references :cost, foreign_key: true

      t.timestamps
    end
  end
end
