class SessionsController  < Devise::OmniauthCallbacksController
  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      @credential = User.create_from_auth!(auth)
      @user = @credential.user
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end
