require "test_helper"

class CachesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get caches_index_url
    assert_response :success
  end
end
