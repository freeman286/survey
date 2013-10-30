class Answer < ActiveRecord::Base
  attr_accessible :id, :no, :sub_question_id, :user_id, :yes
  
  validates :id, presence: true
  
  validates :sub_question_id, presence: true
  
  validates :user_id, presence: true
  
  belongs_to :user
  belongs_to :sub_question
  
  def set_yes!(user)
    self.yes = true
    self.no = false
    save!
  end
  
  def set_no!(user)
    self.no = true
    self.yes = false
    save!
  end
  
end
