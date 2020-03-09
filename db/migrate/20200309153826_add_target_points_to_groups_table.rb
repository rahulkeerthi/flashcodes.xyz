class AddTargetPointsToGroupsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :target_points, :integer, default: 5000
  end
end
