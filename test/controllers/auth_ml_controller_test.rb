require "test_helper"

class AuthMlControllerTest < ActionDispatch::IntegrationTest
  test "should get auth_response" do
    get auth_ml_auth_response_url
    assert_response :success
  end
end
