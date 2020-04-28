class RoadTripFacade
  attr_reader :origin, :destination, :direction, :forecast, :id
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @direction = Direction.new(direction_data)
    @forecast = hourly_forecast
    @id = nil
  end

  def hourly_forecast
    HourlyWeather.new(weather_data[:hourly][hours_traveled])
  end

  def arrival_forecast
    "#{forecast.temp.round}, #{forecast.description.titleize}"
  end

  def travel_time
    hours_traveled > 1 ? "#{hours_traveled}" "#{' hours'}" : "#{hours_traveled}" "#{' hour'}"
  end

  def hours_traveled
    (direction.travel_time.tr('^0-9', '').to_i * 0.01).ceil
  end

  def direction_data
    GeocodeService.new.get_directions(origin, destination)
  end

  def weather_data
    WeatherService.new.get_data_via_latlong(direction.lat, direction.long)
  end
end
