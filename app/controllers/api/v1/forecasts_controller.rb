class Api::V1::ForecastsController < ApplicationController
  def show
    geocode_data = GeocodeService.new.get_data(params["location"])
    filtered_data = Geocode.new(geocode_data)
    conn = Faraday.new("https://api.openweathermap.org") do |req|
      req.params["appid"] = ENV["WEATHER_API"]
      req.params["units"] = "imperial"
      req.params["lat"] = filtered_data.lat
      req.params["lon"] = filtered_data.long
      req.params["timezone"] = "UTC -7"
    end
    response = conn.get("/data/2.5/onecall")
    weather_data = JSON.parse(response.body, symbolize_names: true)
  end
end
