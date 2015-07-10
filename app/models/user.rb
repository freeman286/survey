class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :answers

  has_many :transactions

  has_many :views

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_admin?
    admin?
  end

  def self.search(words)
    users = Set.new
    if !words.empty?
      words.split(" ").each do |word|
        users = User.select {|user| user.first_name == word.capitalize || user.last_name == word.capitalize}
      end
    end
    if users.nil?
      users = User.all
    end
    users
  end
end
