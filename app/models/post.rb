class Post < ActiveRecord::Base
  attr_accessible :content, :link, :points, :title
  belongs_to :user
  validates_presence_of :title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end
