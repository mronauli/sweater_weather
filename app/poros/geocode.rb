class Geocode
  attr_reader :lat, :long
  def initialize(data)
    @lat = data[:results][0][:geometry][:bounds][:northeast][:lat]
    @long = data[:results][0][:geometry][:bounds][:northeast][:lng]
  end
end
