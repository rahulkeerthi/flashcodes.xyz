require 'test_helper'

class UserSetControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_set_create_url
    assert_response :success
  end

  test "should get update" do
    get user_set_update_url
    assert_response :success
  end

  test "should get index" do
    get user_set_index_url
    assert_response :success
  end

end
