class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :bio,          length: { maximum: 1000 }
  validates :birthplace,   length: { maximum: 50 }
  validates :currentplace, length: { maximum: 50 }
  validates :education,    length: { maximum: 50 }
  validates :occupation,   length: { maximum: 50 }
end