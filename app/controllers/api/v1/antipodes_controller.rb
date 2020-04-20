class Api::V1::AntipodesController < ApplicationController
  def show
    data = GeocodeService.new.get_data_via_location(params["location"])
    geocode = Geocode.new(data)
    antipode_data = AntipodeService.new.get_data(geocode.lat, geocode.long)
    antipode = Antipode.new(antipode_data)
    require "pry"; binding.pry
    anti_pode_location_data = GeocodeService.new.get_data_via_latlong(antipode.lat, antipode.long)
    city_name = anti_pode_location_data[:results][3][:formatted_address]
    data = WeatherService.new.get_data_via_city(city_name)
    summary = data[:weater][0][:main]
    current_temperature = data[:main][:temp]
    city_name = data[:name]
  end
end
