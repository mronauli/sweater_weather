class Antipode
  attr_reader :lat, :long
  def initialize(data)
    @lat = data[:data][:attributes][:lat]
    @long = data[:data][:attributes][:long]
  end
end
