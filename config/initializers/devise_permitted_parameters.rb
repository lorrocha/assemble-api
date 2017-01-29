module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :profile_text, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:username, :profile_text, :email)
    end
  end

end

DeviseController.send :include, DevisePermittedParameters
