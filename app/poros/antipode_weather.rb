class AntipodeWeather
  def initialize(data)
    @summary = data[:weather][0][:main]
    @current_temperature = data[:main][:temp]
  end
end
