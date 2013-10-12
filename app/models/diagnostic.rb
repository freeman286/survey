class Diagnostic < ActiveRecord::Base
  attr_accessible :description, :name
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :description, presence: true, length: { minimum: 2}
  
  has_many :segments, dependent: :destroy

end
