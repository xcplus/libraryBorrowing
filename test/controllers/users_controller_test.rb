require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create valid user" do
    post users_url, params: {
      username: users(:one).username,
      password: "password1",
      balance: users(:one).balance
    }
    assert_equal("success", response.parsed_body["status"])
    assert_not_nil response.parsed_body["data"]["user_id"]
  end

  test "create user with invalid password" do
    post users_url, params: {
      username: users(:one).username,
      password: "",
      balance: users(:one).balance
    }
    assert_equal( {"status"=>"error", "message"=>"Password can't be blank,Password is too short (minimum is 6 characters)"}, response.parsed_body)
  end

  test "create user with invalid username" do
    post users_url, params: {
      username: "1",
      password: "abc1234",
      balance: users(:one).balance
    }
    assert_equal({"status"=>"error", "message"=>"Username is too short (minimum is 3 characters)"}, response.parsed_body)
  end
end
