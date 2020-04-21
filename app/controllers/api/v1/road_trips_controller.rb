class Api::V1::RoadTripsController < ApplicationController
  def create
    user =  User.find_by_api_key(params[:api_key])
    if user
      roadtrip = RoadTripFacade.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(roadtrip)
    else
      render json: {status: 401, text: 'Unauthorized.'}
    end
  end
end
