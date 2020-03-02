class CreateCardSets < ActiveRecord::Migration[6.0]
  def change
    create_table :card_sets do |t|
      t.string :title
      t.text :description
      t.string :difficulty
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
