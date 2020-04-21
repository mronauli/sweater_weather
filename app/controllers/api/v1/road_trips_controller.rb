class Api::V1::RoadTripsController < ApplicationController

  def create
    user =  User.find_by_api_key(params[:api_key])
    if user
      direction_data = GeocodeService.new.get_directions(params["origin"], params["destination"])
      travel_time = direction_data[:routes][0][:legs][0][:duration][:text]
      formatted_travel_time = "#{travel_time.tr('^0-9', '').to_i / 60}" "#{' hours'}" if travel_time.tr('^0-9', '').to_i > 60
      lat = direction_data[:routes][0][:legs][0][:end_location][:lat]
      long = direction_data[:routes][0][:legs][0][:end_location][:lng]
      weather_data = WeatherService.new.get_data_via_latlong(lat, long)
      temp_at_arrival = travel_time.tr('^0-9', '').to_i > 60 ? weather_data[:hourly][formatted_travel_time.tr('^0-9', '').to_i - 1][:temp] : weather_data[:hourly][0][:temp]
      description_at_arrival = travel_time.tr('^0-9', '').to_i > 60 ? weather_data[:hourly][formatted_travel_time.tr('^0-9', '').to_i - 1][:weather][0][:description] : weather_data[:hourly][0][:weather][0][:description]
    else
      render json: {status: 401, text: 'Unauthorized.'}
    end
  end

end
