class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :items, through: :lists
  validates :username, :uniqueness => {:message => "username already exists."}
  validates_presence_of :username, :email, :password

end
