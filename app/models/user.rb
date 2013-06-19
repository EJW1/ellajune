class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, :city, :state, :country, :website, :birthday, :address, :latitude, :longitude, :interest_tag_list
  validates_presence_of :name, :username
  validates_uniqueness_of :username, :case_sensitive => false
  has_many :posts
  has_many :votes
  has_many :comments
  has_many :interest_taggings
  has_many :interest_tags, through: :interest_taggings

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  geocoded_by :address
  after_validation :geocode

  def address
    [city, state, country].compact.join(', ')
  end

  def self.search(search)
    if search
      self.where('name ILIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  #Tagging Logic
  def self.tagged_with(name)
    InterestTag.find_by_name!(name).users
  end

  def self.tag_counts
    InterestTag.select("interest_tags.id, interest_tags.name, count(interest_taggings.interest_tag_id) as count").
      joins(:interest_taggings).group("interest_taggings.interest_tag_id, interest_tags.id, interest_tags.name")
  end
  
  def interest_tag_list
    interest_tags.map(&:name).join(", ")
  end
  
  def interest_tag_list=(names)
    self.interest_tags = names.split(",").map do |n|
      InterestTag.where(name: n.strip.downcase).first_or_create!
    end
  end

end
