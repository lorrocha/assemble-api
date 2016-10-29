class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :update, :destroy]

  # GET /alerts
  def index
    @alerts = Alert.all
    @user = User.find(alert_params["user_id"]) if alert_params["user_id"]
    @team = Team.find(alert_params["team_id"]) if alert_params["team_id"]

    if @user && @team
      @alerts = @user.alerts.where(team_id: alert_params["team_id"])
    elsif @team
      @alerts = @team.alerts
    elsif @user
      @alerts = @user.alerts
    end

    render json: @alerts
  end

  # GET /alerts/1
  def show
    render json: @alert
  end

  # POST /alerts
  def create
    @alert = Alert.new(alert_params)

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alerts/1
  def update
    if @alert.update(alert_params)
      render json: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alerts/1
  def destroy
    @alert.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.permit(:alert_text, :user_id, :team_id)
    end
end
