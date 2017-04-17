class Api::UsersController < ApplicationController
  before_action :find_me

  def show
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