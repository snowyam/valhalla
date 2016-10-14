class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :first_name,  presence: true, length: { maximum: 50}
  validates :last_name,  presence: true, length: { maximum: 50}

  def name
    first_name + " " + last_name
  end

  def feed
    Post.where("user_id = ?", id)
  end
end
