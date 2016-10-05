require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:example)
  end

  test "unsuccessful edit" do
    sign_in @user
    get edit_user_registration_path
    assert_template 'registrations/edit'
    patch users_path, params: { user: { first_name: "",
                                        last_name:  "",
                                        email:      "foo@bar",
                                        password:              "foo",
                                        password_confirmation: "bar",
                                        current_password:      "" } }
    assert_template 'registrations/edit'
  end

  test "successful edit" do
    sign_in @user
    get edit_user_registration_path
    assert_template 'registrations/edit'
    first_name = "Exam"
    last_name  = "Sam"
    email      = "foo@example.com"
    patch users_path, params: { user: { first_name: first_name,
                                        last_name:  last_name,
                                        email:      email,
                                        password:              "",
                                        password_confirmation: "",
                                        current_password: "password" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name, @user.first_name
    assert_equal last_name,  @user.last_name
    assert_equal email,      @user.email
  end
end
