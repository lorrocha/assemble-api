require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    @alert = alerts(:one)
    @alert2 = alerts(:two)
    sign_in @user
  end

  test "users/:user_id/alerts should only show alerts for teams the user is part of" do
    get user_alerts_url(@user), as: :json

    alert_ids = response.parsed_body["data"].map { |d| d["id"] }
    assert_includes(alert_ids, @alert.id.to_s)
    assert_not_includes(alert_ids, @alert2.id.to_s)
    assert_response :success
  end
end
