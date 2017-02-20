class Api::TrackersController < ApplicationController
  def index
    render json: Tracker.all
  end
end