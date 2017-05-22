class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied,
              with: -> (exception) { render_error 403, exception }

  rescue_from ActiveRecord::RecordNotFound, with: :active_record_not_found_error

  rescue_from ActiveRecord::RecordInvalid, with: :active_record_invalid_error

  def current_ability
    @current_ability ||= Ability.new(current_user)
    @current_ability
  end

  def active_record_not_found_error(exception)
    error = {
      name: "ActiveRecord::RecordNotFound",
      message: "exceptions.activerecord.not_found"
    }

    respond_to do |format|
      format.json { render json: {error: error}, status: :unprocessable_entity }
    end
  end

  def active_record_invalid_error(exception)
    resource = exception.record
    errors = resource.errors.map do |attribute, message|
      {
        resource: resource.class.to_s,
        field: attribute,
        message: resource.errors.full_message(attribute, message)
      }
    end
    respond_to do |format|
      format.json { render json: {errors: errors}, status: :unprocessable_entity }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :gender])
  end
end
