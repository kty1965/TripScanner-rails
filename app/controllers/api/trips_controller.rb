class Api::TripsController < ApplicationController
  load_and_authorize_resource :trip, through: :current_user

  def index
    render json: @trips
  end

  def show
    render json: @trip
  end

  def create
    @trip = current_user.trips.create!(trip_params)
    render json: @trip
  end

  def update
    @trip.update!(trip_params)
    render json: @trip
  end

  def destroy
    @trip.destroy!
    render json: {}
  end

  private

  def trip_params
    params.require(:trip).permit(:check_in, :check_out, :address)
  end
end