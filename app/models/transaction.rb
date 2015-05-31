class Transaction < ActiveRecord::Base
  attr_accessible :security_hash, :user_id, :diagnostic_id, :completed

  belongs_to :user

  belongs_to :diagnostic

  validates :security_hash, presence: true

  validates :user_id, presence: true

  validates :diagnostic_id, presence: true

  validates_uniqueness_of :security_hash

  before_validation :set_hash

  def set_hash
    self.security_hash = Digest::MD5.hexdigest("#{self.diagnostic_id}-#{self.user_id}")
  end

end
