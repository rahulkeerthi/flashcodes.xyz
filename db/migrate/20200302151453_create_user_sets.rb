class CreateUserSets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card_set, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
