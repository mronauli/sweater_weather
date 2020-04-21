class Geocode
  attr_reader :lat, :long, :country
  def initialize(data)
    @lat = data[:results][0][:geometry][:bounds][:northeast][:lat]
    @long = data[:results][0][:geometry][:bounds][:northeast][:lng]
    @country = data[:results][0][:address_components][3][:long_name]
  end
end
