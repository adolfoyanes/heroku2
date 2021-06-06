class CreateMlAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :ml_auths do |t|
      t.string :token
      t.string :refresh_token
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
