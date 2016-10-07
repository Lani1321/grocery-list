class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :items, through: :lists
  validates_uniqueness_of :username
  validates_presence_of :username, :email, :password

end
