class Post < ActiveRecord::Base
  attr_accessible :content, :link, :points, :title, :user_id
  belongs_to :user
  has_many :votes
  validates_presence_of :title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  #Search
  def self.search(search)
      find(:all, :conditions => ['title LIKE ? OR link LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
