class RemoveLanguageReferenceFromGroupMemberships < ActiveRecord::Migration[6.0]
  def change
    remove_column :group_memberships, :language_id
    change_column_default :group_memberships, :points, 0
  end
end
