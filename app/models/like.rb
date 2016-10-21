class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  # Like a post only once.
  validates_uniqueness_of :user_id, scope: [:post_id]
end
