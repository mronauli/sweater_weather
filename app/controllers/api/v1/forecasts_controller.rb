class Api::V1::ForecastsController < ApplicationController
  def show
    geocode_data = GeocodeService.new.get_data(params["location"])
    geocode = Geocode.new(geocode_data)
    weather_data = WeatherService.new.get_data(geocode.lat, geocode.long)
  end
end
