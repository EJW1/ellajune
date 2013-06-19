class InterestTag < ActiveRecord::Base
  attr_accessible :name
  has_many :interest_taggings
  has_many :users, through: :interest_taggings
end
