class DailyWeather
  def initialize(data)
    @day = Time.at(data[:dt]).strftime("%A")
    @max = data[:temp][:max]
    @min = data[:temp][:min]
    @description = data[:weather][0][:main]
    @icon = data[:weather][0][:icon]
    @rain = data[:rain]
  end
end
