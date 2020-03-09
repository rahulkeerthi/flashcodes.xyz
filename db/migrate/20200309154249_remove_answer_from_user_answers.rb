class RemoveAnswerFromUserAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_answers, :answer
  end
end
