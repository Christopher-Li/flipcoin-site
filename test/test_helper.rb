ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def is_logged_in?
    session[:user_id].nil?
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(user, password: 'password')
    # post login_path, params: { session: { email: user.email,
    #                                       password: password} }
    post login_path, params: { session: { email: User.first,
                                          password: password} }
  end
end