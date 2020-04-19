class HourlyWeather
  def initialize(data)
    @date = Time.at(data[:dt]).strftime("%-I %p")
    @temp = data[:temp]
    @icon = data[:weather][0][:icon]
  end
end