class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # This method returns all the friendships, no matter if the user sent or received the friendship request

  def friends
    return friendships_confirmed + inverse_friendships_confirmed
  end

  # Friendship methods will return an array containing pending or confirmed friends, based on the where clause condition

  def friendships_pending
    friendships_pending = []
    friendships.where(confirmed: false).each { |fs| friendships_pending << User.find(fs.friend_id) }
    friendships_pending
  end

  def inverse_friendships_pending
    inverse_friendships_pending = []
    inverse_friendships.where(confirmed: false).each { |fs| inverse_friendships_pending << User.find(fs.user_id) }
    inverse_friendships_pending
  end

  def friendships_confirmed
    friendships_confirmed = []
    friendships.where(confirmed:true).each { |fs| friendships_confirmed << User.find(fs.friend_id) }
    friendships_confirmed
  end

  def inverse_friendships_confirmed
    inverse_friendships_confirmed = []
    inverse_friendships.where(confirmed: true).each { |fs| inverse_friendships_confirmed << User.find(fs.user_id) }
    inverse_friendships_confirmed
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
