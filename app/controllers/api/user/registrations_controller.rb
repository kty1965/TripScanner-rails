class Api::User::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def resource_name
    :user
  end
end