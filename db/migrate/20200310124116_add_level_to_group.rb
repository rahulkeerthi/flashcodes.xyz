class AddLevelToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :level, :integer, default: 1
  end
end
