class AddLanguageReferenceToGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :language, null: false, foreign_key: true
  end
end
