class SubQuestion < ActiveRecord::Base
  attr_accessible :name, :question_id
  
  belongs_to :question
end
