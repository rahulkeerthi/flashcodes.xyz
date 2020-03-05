class AddLastAttemptedToUserSet < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sets, :last_attempted, :timestamp
  end
end
