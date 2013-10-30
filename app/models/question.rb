class Question < ActiveRecord::Base
  attr_accessible :name, :segment_id
  
  belongs_to :segment
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :segment_id, presence: true
    
  has_many :sub_questions, dependent: :destroy
end
