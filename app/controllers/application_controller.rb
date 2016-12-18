class ApplicationController < ActionController::API
  before_action :initialize_omniauth_state

  private

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
