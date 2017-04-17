class Api::User::SessionsController < Devise::SessionsController
  respond_to :json

  def resource_name
    :user
  end
end