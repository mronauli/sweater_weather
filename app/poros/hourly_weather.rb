class HourlyWeather
  attr_reader :temp, :description
  def initialize(data)
    @date = Time.at(data[:dt]).strftime("%-I %p")
    @temp = data[:temp].round
    @icon = data[:weather][0][:icon]
    @description = data[:weather][0][:description]
  end
end
