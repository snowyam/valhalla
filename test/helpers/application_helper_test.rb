require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,         "Valhalla"
    assert_equal full_title("Help"), "Valhalla | Help"
  end

end