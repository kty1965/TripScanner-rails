class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_me_or_user, only: [:show, :update]

  def show
    render json: @user, serializer: user_serializer
  end

  def update
    authorize! :manage, @user
    @user.update!(user_params)
    render json: @user, serializer: ::Users::ShowSerializer
  end

  private

  def user_serializer
    if can? :manage, @user
      ::Users::ShowSerializer
    else
      ::UserSerializer
    end
  end

  def find_me_or_user
    if params[:id] == 'me'
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:date_of_birth, :name, :gender, :mobile_number,
      :locale, :country, :introduction, :school, :job, :image, :image_data)
  end
end