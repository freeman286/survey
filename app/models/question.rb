class Question < ActiveRecord::Base
  attr_accessible :name, :segment_id
  
  belongs_to :segment
  
  has_many :sub_questions
end
