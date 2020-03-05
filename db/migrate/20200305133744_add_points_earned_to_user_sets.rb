class AddPointsEarnedToUserSets < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sets, :points_earned, :integer
  end
end
