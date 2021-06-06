require "test_helper"

class ConectarMlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get conectar_ml_index_url
    assert_response :success
  end
end
