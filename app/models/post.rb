class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2000 }
end
