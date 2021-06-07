class CreateMlListings < ActiveRecord::Migration[6.1]
  def change
    create_table :ml_listings do |t|
      t.string :ml_id
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
