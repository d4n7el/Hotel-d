require 'test_helper'

class CoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coats_index_url
    assert_response :success
  end

end
