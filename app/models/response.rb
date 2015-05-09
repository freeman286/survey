class Response < ActiveRecord::Base
  belongs_to :segment
  attr_accessible :description, :value, :segment_id

  validates :description, presence: true

  validates :value, presence: true

  validates :value, presence: true, :numericality => {
    greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  }

  validates :segment_id, presence: true
end
