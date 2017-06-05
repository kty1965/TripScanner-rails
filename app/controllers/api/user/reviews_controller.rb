class Api::User::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:owned]
  load_resource :user

  def owned
    @reviews = @user.owned_reviews.written
    render json: @reviews
  end
end