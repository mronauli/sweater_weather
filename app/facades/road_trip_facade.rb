class RoadTripFacade
  attr_reader :origin, :destination, :direction, :id
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @direction = Direction.new(direction_data)
    @id = nil
  end

  def arrival_forecast
    "#{temp_at_arrival.round}, #{description_at_arrival.titleize}"
  end

  def description_at_arrival
    if travel_hours > 60
      weather_data[:hourly][travel_time.tr('^0-9', '').to_i - 1][:weather][0][:description]
    else
      weather_data[:hourly][0][:weather][0][:description]
    end
  end

  def temp_at_arrival
    if travel_hours > 60
      weather_data[:hourly][travel_time.tr('^0-9', '').to_i - 1][:temp]
    else
      weather_data[:hourly][0][:temp]
    end
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
