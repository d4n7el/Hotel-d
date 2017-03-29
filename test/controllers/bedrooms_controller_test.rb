require 'test_helper'

class BedroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bedrooms_index_url
    assert_response :success
  end

end
