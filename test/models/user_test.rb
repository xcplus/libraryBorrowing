require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(username: "textuser", password: "password", balance: 100.0)
    assert user.valid?
  end

  test "user is not valid without a username" do
    user = User.new(username: "", password: "password", balance: 100.0)
    assert_not user.valid?
  end
end
