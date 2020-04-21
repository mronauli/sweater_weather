class RoadTripFacade
  attr_reader :origin, :destination, :direction
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @direction = Direction.new(direction_data)
    @temp_at_arrival = travel_hours > 60 ? weather_data[:hourly][formatted_travel_time.tr('^0-9', '').to_i - 1][:temp] : weather_data[:hourly][0][:temp]
    @description_at_arrival = travel_hours > 60 ? weather_data[:hourly][formatted_travel_time.tr('^0-9', '').to_i - 1][:weather][0][:description] : weather_data[:hourly][0][:weather][0][:description]
  end

  def formatted_travel_time
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
