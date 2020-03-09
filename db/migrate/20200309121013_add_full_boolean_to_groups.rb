class AddFullBooleanToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :full, :boolean
  end
end
