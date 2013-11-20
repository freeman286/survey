class Question < ActiveRecord::Base
  attr_accessible :name, :segment_id
  
  belongs_to :segment
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :segment_id, presence: true
    
  has_many :sub_questions, dependent: :destroy
  
  def complete_for_user(user)
    complete = 0
    total = 0
    self.sub_questions.each do |sub|
      sub_question = sub.class.where(question_id: self.id, id: sub.id).first
      total += 1
      if sub_question.yes?(user) || sub_question.no?(user)
        complete += 1
      end
    end
    if complete == 0 || total == 0
      0
    else
      ((complete + 0.0) / (total + 0.0) * 100).floor
    end
  end
end
