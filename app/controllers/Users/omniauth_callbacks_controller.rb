class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  def google_apps
    @user = User.find_for_google_apps(auth)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      @user.role = "support"
      @user.save
      sign_in_and_redirect @user, :event => :authentication
    end
  end

  def failure
    logger.info params.inspect
    logger.info failure_message.inspect
    render nothing: true
  end

  private

  def auth ; request.env["omniauth.auth"] ; end
end

