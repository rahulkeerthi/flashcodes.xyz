class AddAnswerToUserAnswers2 < ActiveRecord::Migration[6.0]
  def change
    add_column :user_answers, :answer, :string
  end
end
