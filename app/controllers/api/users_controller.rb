class Api::UsersController < ApplicationController
  before_action :find_me, only: [:show, :update]

  def show
    render json: @user, serializer: ::Users::ShowSerializer
  end

  def update
    @user.update!(user_params)
    render json: @user, serializer: ::Users::ShowSerializer
  end

  private

  def find_me
    if params[:id] == 'me'
      authenticate_user!
      @user = current_user
    end
  end

  def user_params
    params.require(:user).permit(:date_of_birth, :name, :gender, :mobile_number,
      :locale, :country, :introduction, :school, :job, :image, :image_data)
  end
end