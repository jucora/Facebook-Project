class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2000 }

	scope :most_recent, -> { order('created_at DESC') }
end
