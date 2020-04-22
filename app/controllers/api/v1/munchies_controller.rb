class Api::V1::MunchiesController < ApplicationController
  def show
     munchie_trip = RoadTripFacade.new(params[:start], params[:end], params[:food])
     render json: MunchieSerializer.new(munchie_trip)
  end
end
