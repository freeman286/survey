class SubQuestion < ActiveRecord::Base
  attr_accessible :name, :question_id, :evidence
  
  belongs_to :question
end
