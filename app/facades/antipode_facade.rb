class AntipodeFacade
  attr_reader :antipode, :city_name, :search_location, :geocode, :forecast, :id
  def initialize(location)
    @search_location = location
    @geocode = GeocodeAntipode.new(geocode_via_location)
    @antipode = Antipode.new(antipode_data)
    @city_name = geocode_via_latlong[:results][3][:formatted_address]
    @forecast = AntipodeWeather.new(antipode_weather_data)
    @id = nil
  end

  def geocode_via_location
    GeocodeService.new.get_data_via_location(search_location)
  end

  def antipode_data
    AntipodeService.new.get_data(geocode.lat, geocode.long)
  end

  def geocode_via_latlong
    GeocodeService.new.get_data_via_latlong(antipode.lat, antipode.long)
  end

  def antipode_weather_data
    WeatherService.new.get_data_via_city(city_name)
  end
end
