class Api::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def owned
    @reviews = current_user.owned_reviews
    render json: @reviews
  end

  def written
    @reviews = current_user.written_reviews
    render json: @reviews
  end

  def show
    @review = Review.find(params[:id])
    authorize! :show, @review
    render json: @review
  end

  def create
    # can carete only trip members.
    @review = current_user.reviews.create!(review_params)
    render json: @review
  end

  private

  def review_params
    params.require(:review).permit(:rate, :view_scope, :content, :owner_id, :writer_id)
  end
end