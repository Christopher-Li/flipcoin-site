require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "log in as" do
    log_in_as User.first
    assert_match @response, /https:\/\/localhost:3000/
  end

end
