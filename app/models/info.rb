class Info < ActiveRecord::Base
  attr_accessible :content, :name
  validates :name, uniqueness: true
end
