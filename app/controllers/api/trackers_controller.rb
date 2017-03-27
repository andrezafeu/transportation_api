class Api::TrackersController < ApplicationController
  def index
    render json: Tracker.all
  end

  def show
    vehicle = Tracker.where(vehicle_id: params[:id])
    render json: vehicle
  end
end