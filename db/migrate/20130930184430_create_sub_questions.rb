class CreateSubQuestions < ActiveRecord::Migration
  def change
    create_table :sub_questions do |t|
      t.string :name
      t.integer :question_id
      t.string :evidence

      t.timestamps
    end
  end
end
