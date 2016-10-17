require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged-in user" do
    assert_no_difference 'Friendship.count' do
      post friendships_path
    end
    assert_redirected_to new_user_session_path
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Friendship.count' do
      delete friendship_path(friendships(:one))
    end
    assert_redirected_to new_user_session_path
  end

end
