class RoadTripFacade
  attr_reader :origin, :end_location, :direction, :forecast, :id, :food, :restaurant
  def initialize(origin, destination, food = nil)
    @origin = origin
    @end_location = destination.titleize.gsub(/,(?![ ])/, ', ')
    @direction = Direction.new(direction_data)
    @forecast = hourly_forecast.description.capitalize
    @id = nil
    @food = food
    @restaurant = Restaurant.new(restaurant_data)
  end

  def hourly_forecast
    if travel_minutes > 60
      HourlyWeather.new(weather_data[:hourly][travel_time.tr('^0-9', '').to_i])
    else
      HourlyWeather.new(weather_data[:hourly][0])
    end
  end

  def arrival_forecast
    "#{forecast.temp.round}, #{forecast.description.titleize}"
  end

  def travel_time
    "#{travel_minutes / 60}" "#{' hours'}" if travel_minutes > 60
  end

  def travel_minutes
    direction.travel_time.tr('^0-9', '').to_i
  end

  def unix_time
    (Time.now + (travel_minutes / 60).hours).to_i
  end

  def direction_data
    GeocodeService.new.get_directions(origin, end_location)
  end

  def weather_data
    WeatherService.new.get_data_via_latlong(direction.lat, direction.long)
  end

  def restaurant_data
    YelpService.new.get_data(food, end_location, unix_time)
  end
end
