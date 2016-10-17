require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user       = users(:example)
    @other_user = users(:sample)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

  test "should get signup" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should be unauthorized update when not logged in" do
    patch users_path(@user), params: { user: { first_name: "",
                                               last_name:  "",
                                               email:      "foo@example.com",
                                               password:              "",
                                               password_confirmation: "",
                                               current_password:      "password" } }
    assert_response 401
  end

  test "should redirect added_friends when not logged in" do
    get added_friends_user_path(@user)
    assert_redirected_to new_user_session_path
  end

  test "should redirect friend_requests when not logged in" do
    get friend_requests_user_path(@user)
    assert_redirected_to new_user_session_path
  end
end
