class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 12000 }
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commenting_users, through: :comments, source: :user
end
