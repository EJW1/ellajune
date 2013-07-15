require 'will_paginate/array'
include PostsHelper

class Post < ActiveRecord::Base
  attr_accessible :content, :link, :points, :title, :user_id, :post_tag_list, :address, :city, :state, :country, :latitude, :longitude, :video_link
  belongs_to :user
  has_many :votes
  has_many :comments
  has_many :post_taggings
  has_many :post_tags, through: :post_taggings
  validates_presence_of :title

  before_create :embed_video

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  geocoded_by :address
  after_validation :geocode

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"


  #Search
  def self.search(search)
      find(:all, :conditions => ['title LIKE ? OR link LIKE ?', "%#{search}%", "%#{search}%"], :order => 'points DESC')
  end

  def address
    [city, state, country].compact.join(', ')
  end

  def self.citysearch(citysearch)
    Post.near(citysearch, 25).order('points DESC')
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

  #Tagging Logic
  def self.tagged_with(name)
    PostTag.find_by_name!(name).posts
  end

  def self.tag_counts
    PostTag.select("post_tags.id, post_tags.name, count(post_taggings.post_tag_id) as count").
      joins(:post_taggings).group("post_taggings.post_tag_id, post_tags.id, post_tags.name")
  end
  
  def post_tag_list
    post_tags.map(&:name).join(", ")
  end
  
  def post_tag_list=(names)
    self.post_tags = names.split(",").map do |n|
      PostTag.where(name: n.strip.downcase).first_or_create!
    end
  end

  private

    def embed_video
      if self.video_link
        self.video_link = embedded_html(self.video_link)
      end
    end

end
