class View < ActiveRecord::Base
  attr_accessible :user_id, :question_id

  belongs_to :user

  belongs_to :question

  validates :user_id, presence: true

  validates :question_id, presence: true

  validates_uniqueness_of :user_id, :scope => :question_id

end
