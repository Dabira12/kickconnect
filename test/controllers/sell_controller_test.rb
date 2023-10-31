require "test_helper"

class SellControllerTest < ActionDispatch::IntegrationTest
  test "should get sale" do
    get sell_sale_url
    assert_response :success
  end
end
