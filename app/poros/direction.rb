class Direction
  attr_reader :travel_time, :lat, :long
  def initialize(data)
    @travel_time = data[:routes][0][:legs][0][:duration][:text]
    @lat = data[:routes][0][:legs][0][:end_location][:lat]
    @long = data[:routes][0][:legs][0][:end_location][:lng]
  end
end
