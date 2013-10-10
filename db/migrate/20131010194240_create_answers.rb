class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :id
      t.integer :sub_question_id
      t.integer :user_id
      t.boolean :yes
      t.boolean :no

      t.timestamps
    end
  end
end
