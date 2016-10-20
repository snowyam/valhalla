require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:example)
  end

  test "index including pagination" do
    sign_in @user
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    @user.find_friends.paginate(page: 1, per_page: 20).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
