class ForecastFacade
  attr_reader :geocode, :location, :current_weather, :hourly_weather, :daily_weather
  def initialize(location)
    @location = location
    @geocode = Geocode.new(geocode_data)
    @current_weather = CurrentWeather.new(weather_data)
    @hourly_weather = weather_data[:hourly][0,8].map { |hour| HourlyWeather.new(hour) }
    @daily_weather = weather_data[:daily][0,7].map { |day| DailyWeather.new(day) }
  end

  def geocode_data
    GeocodeService.new.get_data(location)
  end

  def weather_data
    WeatherService.new.get_data(geocode.lat, geocode.long)
  end
end
