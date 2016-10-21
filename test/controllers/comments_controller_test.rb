require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user    = users(:example)
    @post    = posts(:galaxy)
    @comment = comments(:starlight)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { user_id: @user.id,
                                               post_id: @post.id,
                                               content: "Lorem ipsum" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy for wrong comment" do
    sign_in users(:example)
    comment = comments(:fire)
    assert_no_difference 'Comment.count' do
      delete comment_path(comment)
    end
    assert_redirected_to root_url
  end

end
