class DailyWeather
  def initialize(data)
    @day = Time.at(data[:dt]).strftime("%A")
    @max = data[:temp][:max].round
    @min = data[:temp][:min].round
    @description = data[:weather][0][:main]
    @icon = data[:weather][0][:icon]
    @rain = data[:rain].round unless data[:rain].nil?
    @snow = data[:snow].round unless data[:snow].nil?
  end
end
