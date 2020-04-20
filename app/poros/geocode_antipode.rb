class GeocodeAntipode
  attr_reader :lat, :long
  def initialize(data)
    @lat = data[:results][0][:geometry][:location][:lat]
    @long = data[:results][0][:geometry][:location][:lng]
  end
end
