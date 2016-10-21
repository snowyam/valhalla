require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ApplicationHelper

  def setup
    @user = users(:example)
  end

  test "profile display" do
    sign_in @user
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h2', text: @user.name
    assert_select 'img.gravatar'
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.posts.paginate(page: 1, per_page: 20).each do |post|
      assert_match post.content, response.body
      assert_match post.likes.count.to_s, response.body
      post.comments.each do |comment|
        assert_match comment.content, response.body
      end
    end
  end

end
