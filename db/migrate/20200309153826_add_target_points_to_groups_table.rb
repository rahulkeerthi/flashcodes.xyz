class AddTargetPointsToGroupsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :target_points, :integer, default: BASE_LEVEL_PTS
  end
end
