class CreateFlashcards < ActiveRecord::Migration[6.0]
  def change
    create_table :flashcards do |t|
      t.text :question
      t.string :correct_answer
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.references :card_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
