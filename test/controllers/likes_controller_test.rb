require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example)
    @post = posts(:galaxy)
    @like = likes(:two)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post likes_path, params: { like: { user_id: @user.id,
                                         post_id: @post.id } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Like.count' do
      delete like_path(@like)
    end
    assert_redirected_to new_user_session_path
  end

end
