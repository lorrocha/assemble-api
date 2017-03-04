class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :ensure_correct_user, only: [:update, :destroy]

  def me
    render json: current_user
  end

  # GET /users
  def index
    if params["team_id"]
      team = Team.find(params["team_id"])
      if current_user.teams.include?(team)
        render json: team.users
      else
        head :forbidden
      end
    else
      render json: current_user.teammates
    end
  end

  # GET /users/1
  def show
    if (current_user.teams & @user.teams).any?
      render json: @user
    else
      head :forbidden
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def ensure_correct_user
      head :forbidden unless current_user == @user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :username, :profile_text, :team_id, :provider, :uid)
    end
end
