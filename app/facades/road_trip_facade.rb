class RoadTripFacade
  attr_reader :origin, :destination, :direction, :forecast, :id, :food, :restaurant
  def initialize(origin, destination, food = nil)
    @origin = origin
    @destination = destination
    @direction = Direction.new(direction_data)
    if travel_minutes > 60
      @forecast = HourlyWeather.new(weather_data[:hourly][travel_time.tr('^0-9', '').to_i])
    else
      @forecast = HourlyWeather.new(weather_data[:hourly][0])
    end
    @id = nil
    @food = food
    @restaurant = Restaurant.new(restaurant_data)
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

  def direction_data
    GeocodeService.new.get_directions(origin, destination)
  end

  def weather_data
    WeatherService.new.get_data_via_latlong(direction.lat, direction.long)
  end

  def restaurant_data
    YelpService.new.get_data(food, destination, (Time.now + (travel_minutes / 60).hours).to_i)
  end
end
