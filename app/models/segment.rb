class Segment < ActiveRecord::Base
  attr_accessible :diagnostic_id, :name
  
  belongs_to :diagnostic
  
  validates :name, presence: true, length: {minimum: 2, maximum: 16}
  
  validates :diagnostic_id, presence: true
  
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


  def score_for_user(user_id)
    total = total(User.where(id: user_id))
    complete = yes(User.where(id: user_id))
    
    
    
    if complete == 0 || total == 0
      0
    else
      (complete + 0.0) / (total + 0.0) * 100
    end
  end
  
  def complete_for_user(user)
    complete = 0
    total = 0
    self.questions.each do |que|
      question = que.class.where(segment_id: self.id, id: que.id).first
      question.sub_questions.each do |sub|
        sub_question = sub.class.where(question_id: question.id, id: sub.id).first
        total += 1
        if sub_question.yes?(user) || sub_question.no?(user)
          complete += 1
        end
      end
    end
    if complete == 0 || total == 0
      0
    else
      ((complete + 0.0) / (total + 0.0) * 100).floor
    end
  end
  
  def segment_roation()
    diagnostic = self.diagnostic
    
    if diagnostic.segments.count > 0
      segment_gap = 360 / diagnostic.segments.count
    else
      segment_gap = 360
    end
    count = 0
    segment_number = 0
    diagnostic.segments.each do |seg|
      if seg.id == self.id
        segment_number = count
      end
      count += 1
    end
    if 360 - (segment_number * segment_gap) == 360 
      0
    else
      360 - (segment_number * segment_gap)
    end
  end
end
