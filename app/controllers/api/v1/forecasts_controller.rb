class Api::V1::ForecastsController < ApplicationController
  def show
    conn = Faraday.new("https://maps.googleapis.com") do |req|
      req.params["key"] = ENV["GOOGLE_API_KEY"]
      req.params["address"] = params["location"]
    end
    response = conn.get("/maps/api/geocode/json")
    geocode_data = JSON.parse(response.body, symbolize_names: true)
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
