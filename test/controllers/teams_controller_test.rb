require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    @team = teams(:one)
    sign_in @user
  end

  test "should get index" do
    get teams_url, as: :json

    team_ids = response.parsed_body["data"].map { |d| d["id"] }
    assert_includes(team_ids, teams(:one).id.to_s)
    assert_includes(team_ids, teams(:two).id.to_s)
    assert_response :success
  end

  test "should filter index by user" do
    get user_teams_url(@user)

    team_ids = response.parsed_body["data"].map { |d| d["id"] }
    assert_includes(team_ids, teams(:one).id.to_s)
    assert_not_includes(team_ids, teams(:two).id.to_s)
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.count') do
      post teams_url, params: { team: { team_name: @team.team_name } }, as: :json
    end

    assert_response 201
  end

  test "should show team" do
    get team_url(@team), as: :json
    assert_response :success
  end

  test "should update team" do
    patch team_url(@team), params: { team: { team_name: @team.team_name } }, as: :json
    assert_response 200
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete team_url(@team), as: :json
    end

    assert_response 204
  end
end
