require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index of users on the requester's teams" do
    sign_in users(:alice)

    get users_url, as: :json

    ids = response.parsed_body["data"].map { |u| u["id"] }
    assert_includes(ids, users(:alice).id.to_s)
    assert_includes(ids, users(:bob).id.to_s)
    assert_not_includes(ids, users(:carol).id.to_s)
    assert_response :success
  end

  test "should get index of users scoped to specific team" do
    sign_in users(:bob)

    get team_users_url(teams(:one)), as: :json

    ids = response.parsed_body["data"].map { |u| u["id"] }
    assert_includes(ids, users(:alice).id.to_s)
    assert_includes(ids, users(:bob).id.to_s)
    assert_not_includes(ids, users(:carol).id.to_s)
    assert_response :success
  end

  test "should not get index of other team's users" do
    sign_in users(:alice)

    get team_users_url(teams(:two)), as: :json

    assert_response :forbidden
  end

  test "should create user" do
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

  test "should transform keys to dash-case" do
    sign_in users(:alice)

    get user_url(users(:alice)), as: :json

    actual = response.parsed_body["data"]["attributes"]["profile-text"]
    expected = "This is Alice's profile"
    assert_equal(expected, actual)
    assert_response :success
  end

  test "should show user if on the same team" do
    sign_in users(:alice)

    get user_url(users(:bob)), as: :json

    assert_response :success
  end

  test "should not show user from a different team" do
    sign_in users(:alice)

    get user_url(users(:carol)), as: :json

    assert_response :forbidden
  end

  test "should not show user unless logged in" do
    user = users(:alice)

    get user_url(user), as: :json

    assert_response :unauthorized
  end

  test "should update user" do
    user = users(:alice)
    sign_in user

    patch(
      user_url(user),
      params: { data: { attributes: { email: "new.email@example.com" } } },
      headers: { "CONTENT-TYPE" => "application/vnd.api+json" },
      as: :json
    )

    assert_equal "new.email@example.com", response.parsed_body["data"]["attributes"]["email"]
    assert_response 200
  end

  test "should accept dash-case when updating" do
    user = users(:alice)
    sign_in user

    patch(
      user_url(user),
      params: { data: { attributes: { "profile-text" => "This is Alice's updated profile" } } },
      headers: { "CONTENT-TYPE" => "application/vnd.api+json" },
      as: :json
    )

    actual = response.parsed_body["data"]["attributes"]["profile-text"]
    expected = "This is Alice's updated profile"
    assert_equal(expected, actual)
    assert_response 200
  end

  test "should not be able to update other user" do
    alice = users(:alice)
    bob = users(:bob)
    sign_in alice

    patch(
      user_url(bob),
      params: { data: { attributes: { email: "new.email@example.com" } } },
      headers: { "CONTENT-TYPE" => "application/vnd.api+json" },
      as: :json
    )

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
