require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
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
    @user.save
  end

  test "account_activation" do
    mail = UserMailer.account_activation @user
    assert_equal "Activate your FlipCoin account today!", mail.subject
    assert_equal ["user@example.com"], mail.to
    assert_equal ["flipcoinhelp@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["flipcoinhelp@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
