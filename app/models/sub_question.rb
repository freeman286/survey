class SubQuestion < ActiveRecord::Base
  attr_accessible :name, :question_id, :evidence, :value
  
  belongs_to :question
  has_many :user
  
  has_many :answers
  
  validates :name, presence: true, length: { minimum: 2}
  validates :value, presence: true
  
  validates :value, presence: true, :numericality => {
    greater_than: 0, less_than_or_equal_to: 100
  }
  
  def yes?(user)
    answer = Answer.find_by_user_id_and_sub_question_id(user, self.id)
    if answer.nil?
      false
    elsif answer.yes?
      true
    else
      false
    end
  end
  
  def no?(user)
    answer = Answer.find_by_user_id_and_sub_question_id(user, self.id)
    if answer.nil?
      false
    elsif answer.no?
      true
    else
      false
    end
  end
end
