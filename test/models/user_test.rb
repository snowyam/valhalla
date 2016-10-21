require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example",
                     last_name: "User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "   "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foobar.COM A_US-EN@foo.bar.org
                        first.last@foo.jp alice+bob@name.uk]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid?, "#{valid_addresses.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "should add friend and unfriend a user" do
    egg = users(:example)
    sam = users(:sample)
    assert_not egg.added_friend?(sam)
    egg.add_friend(sam)
    assert egg.added_friend?(sam)
    assert sam.friend_requests.include?(egg)
    egg.unfriend(sam)
    assert_not egg.added_friend?(sam)
  end

  test "feed should have the right posts" do
    example = users(:example)
    sample  = users(:sample)
    odin    = users(:odin)
    freya   = users(:freya)
    # Posts from a friend
    freya.posts.each do |friend_posts|
      assert example.feed.include?(friend_posts)
    end
    # Posts from self
    example.posts.each do |self_posts|
      assert example.feed.include?(self_posts)
    end
    # Posts from a requested friend
    odin.posts.each do |friend_requested_posts|
      assert_not example.feed.include?(friend_requested_posts)
    end
    # Posts from an unfriended
    sample.posts.each do |not_friend_posts|
      assert_not example.feed.include?(not_friend_posts)
    end
  end

  test "associated likes with user should be destroyed" do
    @user.save
    @post = @user.posts.create!(content: "Lorem ipsum")
    @post.likes.create!(user_id: @user.id)
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end

  test "associated comments with user should be destroyed" do
    @user.save
    @post = @user.posts.create!(content: "Lorem ipsum")
    @post.comments.create!(user_id: @user.id,
                          content: "Lorem ipsum")
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end
  
end
