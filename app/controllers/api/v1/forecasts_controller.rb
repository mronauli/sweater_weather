class Api::V1::ForecastsController < ApplicationController
  def show
    conn = Faraday.new("https://maps.googleapis.com") do |req|
      req.params["key"] = ENV["GOOGLE_API_KEY"]
      req.params["address"] = params["location"]
    end
    response = conn.get("/maps/api/geocode/json")
    geocode_data = JSON.parse(response.body, symbolize_names: true)

    lat = geocode_data[:results][0][:geometry][:bounds][:northeast][:lat]
    long = geocode_data[:results][0][:geometry][:bounds][:northeast][:lng]

    conn = Faraday.new("https://api.openweathermap.org") do |req|
      req.params["appid"] = ENV["WEATHER_API"]
      req.params["units"] = "imperial"
      req.params["lat"] = lat
      req.params["lon"] = long
      req.params["timezone"] = "UTC -7"
    end
    response = conn.get("/data/2.5/onecall")
    weather_data = JSON.parse(response.body, symbolize_names: true)
  end
end
