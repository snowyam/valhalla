require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  def setup
    @user = users(:example)
    @profile = @user.profile
  end

  test "should be valid" do
    assert @profile.valid?
  end

  test "user id should be present" do
    @profile.user_id = nil
    assert_not @profile.valid?
  end

end
