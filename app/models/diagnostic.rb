class Diagnostic < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :segments
  
end
