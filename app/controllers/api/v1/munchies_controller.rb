class Api::V1::MunchiesController < ApplicationController
  def show
     direction_data = GeocodeService.new.get_directions(params[:start], params[:end])
     direction = Direction.new(direction_data)
     restaurant_data = YelpService.new.get_data(params[:food], params[:end], (Time.now + (direction.travel_time.tr('^0-9', '').to_i / 60).hours).to_i)
     restaurant_name = restaurant_data[:businesses][0][:name]
     restaurant_address = restaurant_data[:businesses][0][:location][:display_address]
     munchie_weather = RoadTripFacade.new(params[:start], params[:end], params["food"])
     hourly_weather = munchie_weather.forecast
     forecast = hourly_weather.description
     require "pry"; binding.pry
  end
end
