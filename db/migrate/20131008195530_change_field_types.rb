class ChangeFieldTypes < ActiveRecord::Migration
  def change
   change_column :questions, :name, :text
   change_column :sub_questions, :name, :text
   change_column :sub_questions, :evidence, :text
  end
end
