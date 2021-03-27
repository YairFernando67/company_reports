require 'test_helper'

class DesignPatterns::FacadeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get design_patterns_facade_index_url
    assert_response :success
  end

end
