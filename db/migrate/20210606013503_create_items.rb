class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :barcode
      t.integer :available_quantity
      t.boolean :visible
      t.references :seller, null: false, foreign_key: true

      t.timestamps
    end
  end
end
