class Api::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:owned, :written, :create]
  # load_resource only: [:show]

  #current_user
  def owned
    @reviews = current_user.owned_reviews
    render json: @reviews
  end

  #current_user
  def written
    @reviews = current_user.written_reviews
    render json: @reviews
  end

  #current_user
  def create
    # can carete only trip members.
    # other members create
    @review = current_user.reviews.create!(review_params)
    render json: @review
  end

  #load_and_authorize
  def show
    # Cannot authorize
    render json: @review
  end

  private

  def review_params
    params.require(:review).permit(:rate, :view_scope, :content, :owner_id, :writer_id)
  end
end