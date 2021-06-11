class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :resource
      t.integer :user_id
      t.string :topic
      t.integer :application_id
      t.integer :attempts
      t.date :sent
      t.date :received

      t.timestamps
    end
  end
end
