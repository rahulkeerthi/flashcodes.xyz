class AddActionToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :action, :string
  end
end
