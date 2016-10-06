require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example)
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

  test "should redirect update when not logged in" do
    patch users_path, params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end
end
