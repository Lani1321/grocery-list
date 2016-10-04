class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :items, through: :list_items

  
  def slug
    name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    List.all.find {|list| list.slug == slug}
  end

end