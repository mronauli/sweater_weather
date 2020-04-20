class Api::V1::AntipodesController < ApplicationController
  def show
    data = GeocodeService.new.get_data_via_location(params["location"])
    lat = data[:results][0][:geometry][:location][:lat]
    long = data[:results][0][:geometry][:location][:lng]
    conn = Faraday.new("http://amypode.herokuapp.com") do |req|
      req.headers["api_key"] = ENV["AMY_API"]
      req.params["lat"] = lat
      req.params["long"] = long
    end
    response = conn.get("/api/v1/antipodes")
    antipode_data = JSON.parse(response.body, symbolize_names: true)
    latt = antipode_data[:data][:attributes][:lat]
    longg = antipode_data[:data][:attributes][:long]
    anti_pode_location_data = GeocodeService.new.get_data_via_latlong(latt, longg)
    city_name = anti_pode_location_data[:results][3][:formatted_address]
    data = WeatherService.new.get_data_via_latlong(latt, longg)
    summary = data[:current][:weather][0][:description]
    temp = data[:current][:temp]

  end
end
