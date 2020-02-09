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
    friends_sent = self.friendships.where(confirmed: true)
    friends_sent.each { |fs| friends << User.find(fs.friend_id) }

    friends_received = self.inverse_friendships.where(confirmed: true)
    friends_received.each { |fs| friends << User.find(fs.user_id) }

    friends

    # User.joins(:inverse_friendships).where("friendships.confirmed = true AND friendships.user_id = ?", self.id
  end

  def friends_pending
  	friends_pending = []
  	friendships = self.inverse_friendships.where(confirmed: false)
  	friendships.each do |fs|
  		friends_pending << User.find(fs.user_id)
  	end
  	friends_pending
  end
end
