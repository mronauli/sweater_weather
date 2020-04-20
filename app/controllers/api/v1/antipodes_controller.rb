class Api::V1::AntipodesController < ApplicationController
  def show
    data = GeocodeService.new.get_data(params["location"])
    lat = data[:results][0][:geometry][:location][:lat]
    long = data[:results][0][:geometry][:location][:lng]
    conn = Faraday.new("http://amypode.herokuapp.com") do |req|
      req.headers["api_key"] = ENV["AMY_API"]
      req.params["lat"] = lat
      req.params["long"] = long
    end
    response = conn.get("/api/v1/antipodes")
    antipode_data = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
  end
end
