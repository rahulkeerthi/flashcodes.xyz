require 'test_helper'

class CardSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get card_sets_index_url
    assert_response :success
  end

  test "should get show" do
    get card_sets_show_url
    assert_response :success
  end

end
