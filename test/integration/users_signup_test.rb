require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { first_name: "",
                                          last_name:  "",
                                          email:      "wrong@email",
                                          password:   "foobar",
                                          password_confirmation: "" } }
    end
    assert_template 'registrations/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { first_name: "User",
                                          last_name:  "Example",
                                          email:      "example@example.com",
                                          password:   "password",
                                          password_confirmation: "password" } }
    end
    follow_redirect!
  end

end
