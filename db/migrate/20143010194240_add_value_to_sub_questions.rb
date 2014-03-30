class AddValueToSubQuestions < ActiveRecord::Migration
  def change
    add_column :sub_questions, :value, :integer
  end
end