class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  has_secure_password
  has_many :lists
  has_many :items, through: :lists
  
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end
  
end
