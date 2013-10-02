class Segment < ActiveRecord::Base
  attr_accessible :diagnostic_id, :name
  
  belongs_to :diagnostic
  
  has_many :questions
end