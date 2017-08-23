require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.first
  end

  test "test number of users" do
    # assert_match 2, @user.authenticate('password')
    assert_match 2, User.find_by(email: @user.email).authenticate('password')
  end

  test "should get index" do
    log_in_as @user
    get users_url
    assert_response :success
  end

  test "User access restricted to logged in users" do
    log_in_as @user
    get users_url
    assert_redirected_to '/login'
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post '/signup/', 
        params: { 
          user: { 
            firstName: "Example", 
            lastName: "Name", 
            email: "user@example.com",
            address1: "testtest",
            zipCode: "12345",
            city: "testtest",
            state: "testtest",
            dob: Date.parse('2012-12-20'),
            estimatedContribution: 1.0,
            password: "password", 
            password_confirmation: "password" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as @user
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { admin: @user.admin, email: @user.email, firstName: @user.firstName, lastName: @user.lastName, password: @user.password } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
