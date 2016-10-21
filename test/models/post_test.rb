require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:example)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "content should be at most 12000 characters" do
    @post.content = "a" * 12001
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "associated likes with post should be destroyed" do
    @post.save
    @post.likes.create!(user_id: @user.id)
    assert_difference 'Like.count', -1 do
      @post.destroy
    end
  end

  test "associated comments with post should be destroyed" do
    @post.save
    @post.comments.create!(user_id: @user.id,
                           content: "Lorem ipsum")
    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end

end
