class AntipodeFacade
  attr_reader :data, :lat, :long, :antipode_data, :antipode, :anti_pode_location_data, :city_name, :weather_data
  def initialize(location)
    @data = GeocodeService.new.get_data_via_location(location)
    @lat = data[:results][0][:geometry][:location][:lat]
    @long = data[:results][0][:geometry][:location][:lng]
    @antipode_data = AntipodeService.new.get_data(lat, long)
    @antipode = Antipode.new(antipode_data)
    @anti_pode_location_data = GeocodeService.new.get_data_via_latlong(antipode.lat, antipode.long)
    @city_name = anti_pode_location_data[:results][3][:formatted_address]
    @weather_data = WeatherService.new.get_data_via_city(city_name)
    @weather = AntipodeWeather.new(weather_data)
  end
end
