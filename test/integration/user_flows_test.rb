require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in users(:alice)

    get users_url, as: :json

    assert_response :success
  end

  test "should create user" do
    sign_in users(:alice)

    assert_difference('User.count') do
      params = {
        user: {
          email: "wendy@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
      post users_url, params: params, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    user = users(:alice)
    sign_in user

    get user_url(user), as: :json

    assert_response :success
  end

  test "should not show user unless logged in" do
    user = users(:alice)

    get user_url(user), as: :json

    assert_response :unauthorized
  end

  test "should update user" do
    user = users(:alice)
    sign_in user

    patch user_url(user), params: { user: { email: "new.email@example.com" } }, as: :json
    assert_equal "new.email@example.com", response.parsed_body["data"]["attributes"]["email"]
    assert_response 200
  end

  test "should not be able to update other user" do
    alice = users(:alice)
    bob = users(:bob)
    sign_in alice

    patch user_url(bob), params: { user: { email: "new.email@example.com" } }, as: :json

    assert_response :forbidden
  end

  test "should destroy user" do
    user = users(:alice)
    sign_in user

    assert_difference('User.count', -1) do
      delete user_url(user), as: :json
    end

    assert_response 204
  end

  test "should not be able to destroy other user" do
    alice = users(:alice)
    bob = users(:bob)
    sign_in alice

    assert_difference("User.count", 0) do
      delete user_url(bob), as: :json
    end

    assert_response :forbidden
  end
end
