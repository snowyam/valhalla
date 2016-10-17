require 'test_helper'

class FriendingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user  = users(:example)
    @other = users(:sample)
    sign_in @user
  end

  test "friends list page" do
    get added_friends_user_path(@user)
    assert_not @user.added_friends.empty?
    assert_not @user.friends_list.empty?
    @user.friends_list.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "pending friend requests page" do
    get friend_requests_user_path(@user)
    assert_not @user.friend_requests.empty?
    assert_not @user.pending_friends.empty?
    @user.pending_friends.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "should friend a user the standard way" do
    assert_difference '@user.added_friends.count', 1 do
      post friendships_path, params: { friended_id: @other.id }
    end
  end

  test "should unfriend a user the standard way" do
    @user.add_friend(@other)
    friendship = @user.active_friendships.find_by(friended_id: @other.id)
    assert_difference '@user.added_friends.count', -1 do
      delete friendship_path(friendship)
    end
  end

end
