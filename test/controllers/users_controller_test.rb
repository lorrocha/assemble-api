require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    sign_in @user
  end

  test "index will show all teammates for the current_user" do
    teammate = users(:bob)
    non_teammate = users(:carol)

    get users_url
    assert_response :success
    assert_includes @response.body, teammate.id.to_s
    assert_not_includes @response.body, non_teammate.id.to_s
  end

  test 'index with a given team_id that the current user does not have will return forbidden' do
    team_two = teams(:two)

    get users_url, params: { team_id: team_two.id }
    assert_response :forbidden
  end

  test 'index with a given team_id that the current user does have will return only users for that team' do
    steve = users(:steve)
    sign_in steve
    team_two = teams(:two)

    get users_url, params: { team_id: team_two.id }
    assert_response :success
    assert_includes @response.body, users(:carol).id.to_s
    assert_not_includes @response.body, @user.id.to_s
  end
end
