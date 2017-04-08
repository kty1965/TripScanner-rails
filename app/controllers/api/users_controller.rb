class Api::UsersController < ApplicationController
  before_action :find_me

  def show
    Rails.logger.info user_facebook_omniauth_authorize_path
    render json: @user
  end

  private

  def find_me
    if params[:id] == 'me'
      authenticate_user!
      @user = current_user
    end
  end
end