class AddCounterToUserSet < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sets, :answer_counter, :integer
  end
end
