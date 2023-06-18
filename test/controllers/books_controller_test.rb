require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get income" do
    get books_income_url
    assert_response :success
  end
end
