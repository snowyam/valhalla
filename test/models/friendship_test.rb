require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
    @friendship = Friendship.new(friender_id: users(:example).id,
                                 friended_id: users(:sample).id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a friender_id" do
    @friendship.friender_id = nil
    assert_not @friendship.valid?
  end

  test "should require a friended_id" do
    @friendship.friended_id = nil
    assert_not @friendship.valid?
  end


end
