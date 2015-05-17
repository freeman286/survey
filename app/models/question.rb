class Question < ActiveRecord::Base
  attr_accessible :name, :description, :segment_id

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

  def position
    pos = 0
    loop_pos = 0
    self.segment.questions.each do |que|
      if que.id == self.id
        pos = loop_pos
      end
      loop_pos += 1
    end
    pos
  end

  def next_segment
    if self.segment.last_segment?
      self.segment.diagnostic.segments.first
    else
      self.segment.diagnostic.segments[self.segment.number + 1]
    end
  end

  def previous_segment
    if self.segment.number == 0
      self.segment.diagnostic.segments.last
    else
      self.segment.diagnostic.segments[self.segment.number - 1]
    end
  end

  def last_question?
    self.position == self.segment.questions.count - 1
  end

  def next_question
    if self.last_question?
      self.next_segment.questions.first
    else
      self.segment.questions[self.position + 1]
    end
  end

  def previous_question
    if self.position == 0
      self.previous_segment.last_question
    else
      self.segment.questions[self.position - 1]
    end
  end

end
