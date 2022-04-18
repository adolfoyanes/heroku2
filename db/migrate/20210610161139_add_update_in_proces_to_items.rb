class AddUpdateInProcesToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :update_in_process, :boolean, :default=>0
  end
end
