class SubQuestion < ActiveRecord::Base
  attr_accessible :name, :question_id, :evidence
  
  belongs_to :question
  has_many :user
  
  has_many :answers
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :evidence, presence: true, length: { minimum: 2}
  
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
