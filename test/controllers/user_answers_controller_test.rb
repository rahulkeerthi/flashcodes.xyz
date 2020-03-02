require 'test_helper'

class UserAnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_answers_create_url
    assert_response :success
  end

  test "should get update" do
    get user_answers_update_url
    assert_response :success
  end

  test "should get index" do
    get user_answers_index_url
    assert_response :success
  end

end
