require 'test_helper'

class AlertsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice)
    @team = teams(:one)
    @alert = alerts(:one)
  end

  test "should get index" do
    get team_alerts_url(@team), as: :json
    assert_response :success
  end

  test "should create alert" do
    params = { data: { attributes: { alert_text: "There's an alert going on" } } }

    assert_difference('Alert.count') do
      post team_alerts_url(@team), params: params, as: :json
    end

    assert_response 201
  end

  test "should show alert" do
    get alert_url(@alert), as: :json
    assert_response :success
  end

  test "should show forbidden if the user is not associated with the team for the alert" do
    bad_alert = alerts(:two)
    get alert_url(bad_alert), as: :json
    assert_response :forbidden
  end

  test "should update alert" do
    patch alert_url(@alert), params: { data: { attributes: { alert_text: @alert.alert_text } } }, as: :json
    assert_response 200
  end

  test "should destroy alert" do
    assert_difference('Alert.count', -1) do
      delete alert_url(@alert), as: :json
    end

    assert_response 204
  end
end
