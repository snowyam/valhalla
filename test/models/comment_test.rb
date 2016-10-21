require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:example)
    @post = posts(:galaxy)
    @comment = @post.comments.build(user_id: @user.id,
                                    content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "post id should be present" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "content should be at most 6000 characters" do
    @comment.content = "a" * 6001
    assert_not @comment.valid?
  end

  test "order should be oldest first" do
    assert_equal comments(:oldest), Comment.first
  end

end
