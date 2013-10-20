class Segment < ActiveRecord::Base
  attr_accessible :diagnostic_id, :name
  
  belongs_to :diagnostic
  
  validates :name, presence: true, length: { minimum: 2}
  
  has_many :questions
  
  def yes(user)
    yes = 0
    self.questions.each do |que|
      question = que.class.where(segment_id: self.id, id: que.id).first
      question.sub_questions.each do |sub|
        if sub.yes?(user)
          yes += 1
        end
      end
    end
    yes
  end
  
  def total(user)
    total = 0
    self.questions.each do |que|
      question = que.class.where(segment_id: self.id, id: que.id).first
      question.sub_questions.each do |sub|
        total += 1
      end
    end
    total
  end
end
