class CreateUserAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_answers do |t|
      t.boolean :correct
      t.references :user_set, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
