class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Active friendships are initially outgoing friend requests.
  # Passive friendships are incoming friend requests.
  # Both users with active friendships form a mutual friendship.
  has_many :active_friendships,  class_name:  "Friendship",
                                 foreign_key: "friender_id",
                                 dependent:   :destroy
  has_many :passive_friendships, class_name:  "Friendship",
                                 foreign_key: "friended_id",
                                 dependent:   :destroy                               
  has_many :added_friends,   through: :active_friendships,
                             source:  :friended
  has_many :friend_requests, through: :passive_friendships,
                             source:  :friender
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

  # Home page posts feed.
  def feed
    added_friends_id  = "SELECT friended_id FROM friendships
                         WHERE  friender_id = :user_id"
    mutual_friends_id = "SELECT friender_id FROM friendships
                         WHERE  friended_id = :user_id"

    Post.where("user_id IN (#{added_friends_id})
                AND user_id IN (#{mutual_friends_id})
                OR user_id = :user_id", user_id: self.id)
  end

  # Add a user as a friend / Send friend request.
  def add_friend(other_user)
    active_friendships.create(friended_id: other_user.id)
  end

  # Returns true if current user has added other user as a friend.
  def added_friend?(other_user)
    added_friends.include?(other_user)
  end

  def friend_request?(other_user)
    friend_requests.include?(other_user)
  end

  # Unfriend a user / Cancel friend request.
  def unfriend(other_user)
    if added_friend?(other_user)
      active_friendships.find_by(friended_id: other_user.id).destroy
    end
    if friend_request?(other_user)
      passive_friendships.find_by(friender_id: other_user.id).destroy
    end
  end

  # Return a user's mutual active friendships with other users.
  def friends_list
    added_friends_id  = "SELECT friended_id FROM friendships
                         WHERE  friender_id = :user_id"
    mutual_friends_id = "SELECT friender_id FROM friendships
                         WHERE  friended_id = :user_id"

    User.where("id IN (#{added_friends_id})
                AND id IN (#{mutual_friends_id})", user_id: self.id)
  end

  # Return a user's pending friend requests.
  def pending_friends
    added_friends_id  = "SELECT friended_id FROM friendships
                         WHERE  friender_id = :user_id"
    pending_friends_id = "SELECT friender_id FROM friendships
                         WHERE  friended_id = :user_id"

    User.where("id NOT IN (#{added_friends_id})
                AND id IN (#{pending_friends_id})
                AND NOT id = :user_id", user_id: self.id)
  end

  # Return a list of other users not friends with user.
  def find_friends
    added_friends_id  = "SELECT friended_id FROM friendships
                         WHERE  friender_id = :user_id"
    pending_friends_id = "SELECT friender_id FROM friendships
                         WHERE  friended_id = :user_id"

    User.where("id NOT IN (#{added_friends_id})
                AND id NOT IN (#{pending_friends_id})
                AND NOT id = :user.id", user_id: self.id)
  end

end
