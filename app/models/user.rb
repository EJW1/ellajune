class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, :city, :state, :country, :website, :birthday
  validates_presence_of :name, :username
  validates_uniqueness_of :username, :case_sensitive => false

  def self.search(search)
    if search
      self.where('name LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end
end
