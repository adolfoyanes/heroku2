class AddSynchronizedMlToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :synchronized_ml, :boolean, :default=>0
  end
end
