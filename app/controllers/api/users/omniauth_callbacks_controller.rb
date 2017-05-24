class Api::Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/api/v1/users/auth/facebook?auth_type=rerequest&scope=email"
    end

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    # Force sign_up
    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    # if @user.persisted?
    #   sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    #   # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    # else
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a? User
      # TODO Change localhost:8080
      "http://localhost:8080/"
    else
      super
    end
  end

  def failure
    # TODO Change localhost:8080
    redirect_to "http://localhost:8080/"
  end
end