class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :items, through: :lists
  validates_uniqueness_of :username, :message => 'Oops, looks like someone already has this username, please try another'
  validates_presence_of :username, :email, :password
  
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end
  
end
