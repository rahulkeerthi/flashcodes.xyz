require 'test_helper'

class SetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sets_index_url
    assert_response :success
  end

  test "should get show" do
    get sets_show_url
    assert_response :success
  end

end
