class RoadTripFacade
  attr_reader :origin, :destination, :direction, :forecast, :id
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @direction = Direction.new(direction_data)
    if travel_hours > 60
      @forecast = HourlyWeather.new(weather_data[:hourly][travel_time.tr('^0-9', '').to_i - 1])
    else
      @forecast = HourlyWeather.new(weather_data[:hourly][0])
    end
    @id = nil
  end

  def arrival_forecast
    "#{forecast.temp.round}, #{forecast.description.titleize}"
  end

  def travel_time
    "#{travel_hours / 60}" "#{' hours'}" if travel_hours > 60
  end

  def travel_hours
    direction.travel_time.tr('^0-9', '').to_i
  end

  def direction_data
    GeocodeService.new.get_directions(origin, destination)
  end

  def weather_data
    WeatherService.new.get_data_via_latlong(direction.lat, direction.long)
  end
end
