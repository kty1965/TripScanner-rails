class Api::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:owned, :written, :create, :pending]
  load_and_authorize_resource only: [:show, :update]

  #current_user
  def owned
    @reviews = current_user.owned_reviews.written
    render json: @reviews
  end

  #current_user
  def written
    @reviews = current_user.written_reviews.written
    render json: @reviews
  end

  # no need owned & pending
  def pending
    @reviews = current_user.written_reviews.pending
    render json: @reviews
  end

  #load_and_authorize
  def update
    # other members create
    if @review.pending?
      @review.update!(review_params)
      @review.write
    end
    render json: @review
  end

  #load_and_authorize
  def show
    # Cannot authorize
    render json: @review
  end

  private

  def review_params
    params.require(:review).permit(:rate, :content)
  end
end