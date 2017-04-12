class Api::TrackersController < ApplicationController

  def index
    render json: Tracker.all
  end

  def show
    vehicle = Tracker.where(vehicle_id: params[:id])
    render json: vehicle
  end

  def real_time_position
    position = Tracker.where(vehicle_id: params[:id]).last
    render json: position
  end

end