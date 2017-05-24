class Api::TripsController < ApplicationController
  before_action :date_check, only: [:index]
  before_action :authenticate_user!, only: [:owned, :joined, :create]
  load_and_authorize_resource :trip, only: [:index, :show, :update, :destroy]

  #current_user
  def owned
    @trips = current_user.owned_trips
    render json: @trips
  end

  #current_user
  def joined
    @trips = current_user.joined_trips
    render json: @trips
  end

  #current_user
  def create
    @trip = current_user.owned_trips.create!(trip_params)
    render json: @trip
  end

  #load_and_authorize
  def index
    raise ActiveRecord::RecordNotFound unless address = params[:address]
    res = Geocoder.search(params[:address])
    city = res.try(:first).try(:city)
    country = res.try(:first).try(:country)
    @trips = @trips.where("address LIKE '%#{address}%' or city LIKE '%#{city}%' and country='#{country}'")
    @trips = @trips.where(check_in: @check_in..@check_out, check_out: @check_in..@check_out)
    render json: @trips
  end

  #load_and_authorize
  def show
    render json: @trip
  end

  #load_and_authorize
  def update
    @trip.update!(trip_params)
    render json: @trip
  end

  #load_and_authorize
  def destroy
    @trip.destroy!
    render json: {}
  end

  private

  def date_check
    @check_in = params[:checkIn].to_date
    @check_out = params[:checkOut].to_date
  end

  def trip_params
    params.require(:trip).permit(:check_in, :check_out, :address, :content, :image)
  end
end