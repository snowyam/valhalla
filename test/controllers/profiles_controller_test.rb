require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user    = users(:example)
    @profile = profiles(:exampler)
  end

  test "should redirect edit when not logged in" do
    get edit_profile_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect update when not logged in" do
    patch profile_path(@user), params: { profile: { bio:          "",
                                                    birthday:     "",
                                                    birthplace:   "a",
                                                    currentplace: "a",
                                                    education:    "a",
                                                    occupation:   "a" } }
    assert_redirected_to new_user_session_path
  end

  test "should redirect edit and update for wrong user" do
    sign_in @user
    other_user = users(:sample)
    get edit_profile_path(other_user)
    assert_redirected_to root_url
    patch profile_path(other_user), params: { profile: { bio:          "",
                                                         birthday:     "",
                                                         birthplace:   "a",
                                                         currentplace: "a",
                                                         education:    "a",
                                                         occupation:   "a" } }
    assert_redirected_to root_url
  end

end
