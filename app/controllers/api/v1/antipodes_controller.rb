class Api::V1::AntipodesController < ApplicationController
  def show
    data = GeocodeService.new.get_data_via_location(params["location"])
    geocode = Geocode.new(data)
    conn = Faraday.new("http://amypode.herokuapp.com") do |req|
      req.headers["api_key"] = ENV["AMY_API"]
      req.params["lat"] = geodode.lat
      req.params["long"] = geocode.long
    end
    response = conn.get("/api/v1/antipodes")
    antipode_data = JSON.parse(response.body, symbolize_names: true)
    antipode = Antipode.new(antipode_data)
    anti_pode_location_data = GeocodeService.new.get_data_via_latlong(antipode.lat, antipode.long)
    city_name = anti_pode_location_data[:results][3][:formatted_address]
    data = WeatherService.new.get_data_via_city(city_name)
    summary = data[:weater][0][:main]
    current_temperature = data[:main][:temp]
    city_name = data[:name]
  end
end
