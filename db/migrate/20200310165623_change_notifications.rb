class ChangeNotifications < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :read_at
    remove_column :notifications, :notifiable_id
    remove_column :notifications, :notifiable_type
    rename_column :notifications, :action, :content
  end
end
