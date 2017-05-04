class Api::ReviewsController < ApplicationController
  load_and_authorize_resource :review, through: :current_user

  def index
    render json: @reviews
  end

  def show
    render json: @review
  end

  def create
    @review = current_user.reviews.create!(review_params)
    render json: @review
  end

  private

  def review_params
    params.require(:review).permit(:rate, :view_scope, :content, :owner_id, :writer_id)
  end
end