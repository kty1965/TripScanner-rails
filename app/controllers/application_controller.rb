class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied,
              with: -> (exception) { render_error 403, exception }
end
