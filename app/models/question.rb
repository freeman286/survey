class Question < ActiveRecord::Base
  attr_accessible :name, :description, :segment_id

  belongs_to :segment

  validates :name, presence: true, length: { minimum: 2}

  validates :segment_id, presence: true

  has_many :sub_questions, dependent: :destroy

  has_many :views

  def complete_for_user(user)
    (self.views.where(:user_id => user.id).present? ? 100 : 0)
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
