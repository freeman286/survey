class Segment < ActiveRecord::Base
  attr_accessible :diagnostic_id, :name

  belongs_to :diagnostic

  validates :name, presence: true, length: {minimum: 2, maximum: 30}

  validates :diagnostic_id, presence: true

  has_many :questions

  has_many :responses

  after_save :diagnostic_make_wheel

  after_create :diagnostic_make_wheel

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
    percent = 0
    self.questions.each do |que|
      question = que.class.where(segment_id: self.id, id: que.id).first
      question.sub_questions.each do |sub|
        if sub.yes?(user_id)
          percent += sub.value.to_f
        end
      end
    end
    if self.questions.count > 0
      (percent / self.questions.count).round
    else
      0
    end
  end

  def complete_for_user(user)
    self.questions.map{|q| q.complete_for_user(user)}.sum / self.questions.count
  end

  def segment_roation()
    segment_number = self.number
    diagnostic = self.diagnostic
    if diagnostic.segments.count > 0
      segment_gap = 360 / diagnostic.segments.count
    else
      segment_gap = 360
    end
    if 360 - (segment_number * segment_gap) == 360
      0
    else
      360 - (segment_number * segment_gap)
    end
  end

  def number
    count = 0
    segment_number = 0
    self.diagnostic.segments.each do |seg|
      if seg.id == self.id
        segment_number = count
      end
      count += 1
    end
  segment_number
  end

  def last_segment?
    self.number == self.diagnostic.segments.count - 1
  end

  def last_question
    question = nil
    self.questions.each do |que|
      if que.position == self.questions.count - 1
        question = que
      end
    end
    question
  end

  def diagnostic_make_wheel
    self.diagnostic.make_wheel
  end

  def user_response(user_id)
    self.responses.select{|x| x.value <= score_for_user(User.find(user_id))}.max_by(&:value)
  end
end
