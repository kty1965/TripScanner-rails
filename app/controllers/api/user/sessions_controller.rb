class Api::User::SessionsController < Devise::SessionsController
  respond_to :json

  def resource_name
    :user
  end

  def respond_to_on_destroy
    render json: {}
  end
end