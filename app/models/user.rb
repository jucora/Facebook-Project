class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
  	friends = []
    if user_sent_request?
      friendships = self.friendships.where(confirmed: true)
      friendships.each do |fs|
    		friends << User.find(fs.friend_id)
    	end
    	return friends
    else
      friendships = self.inverse_friendships.where(confirmed: true)
      friendships.each do |fs|
    		friends << User.find(fs.user_id)
    	end
      return friends
    end
  end

  def friends_pending
  	friends_pending = []
  	friendships = self.inverse_friendships.where(confirmed: false)
  	friendships.each do |fs|
  		friends_pending << User.find(fs.user_id)
  	end
  	friends_pending
  end

  def user_sent_request?
    if !self.friendships.first.nil? && self.id == self.friendships.first.user_id
      true
    else
      false
    end
  end
end
