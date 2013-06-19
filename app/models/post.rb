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

  #Votes & Popularity
  def vote_count
    self.votes.count
  end

  def calc_points
    time = (Time.now - created_at)/3600
    points = (vote_count / time*5).ceil
  end

  def self.update_points
    posts = Post.all
    posts.each { |post| post.update_attributes(:points => post.calc_points) }
  end
end
