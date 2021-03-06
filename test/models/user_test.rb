require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(firstName: "Example", 
      lastName: "Name", 
      email: "user@example.com",
      address1: "testtest",
      zipCode: "12345",
      city: "testtest",
      state: "testtest",
      dob: Date.parse('2012-12-20'),
      estimatedContribution: 1.0,
      password: "testtest", 
      password_confirmation: "testtest")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "firstName should be present" do
  	@user.firstName = "   "
  	assert_not @user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end
end