class Api::User::SessionsController < Devise::SessionsController
  respond_to :json

  def resource_name
    :user
  end

  def respond_to_on_destroy
    render json: {}
  end

  def respond_with(resource, opts = {})
    render json: resource, serializer: ::Users::ShowSerializer
  end
end