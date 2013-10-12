class Segment < ActiveRecord::Base
  attr_accessible :diagnostic_id, :name
  
  belongs_to :diagnostic
  
  validates :name, presence: true, length: { minimum: 2}
  
  has_many :questions
end
