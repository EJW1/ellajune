class PostTag < ActiveRecord::Base
  attr_accessible :name
  has_many :post_taggings
  has_many :posts, through: :post_taggings
end
