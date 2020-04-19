class CurrentWeather
  def initialize(data)
    @time = Time.at(data[:current][:dt]).strftime("%-I:%M %p, %B %e")
    @sunrise = Time.at(data[:current][:sunrise]).strftime("%-I:%M %p")
    @sunset = Time.at(data[:current][:sunset]).strftime("%-I:%M %p")
    @feels_like = data[:current][:feels_like].round
    @humidity = data[:current][:humidity]
    @visibility = (data[:current][:visibility] / 1609.34).round
    @uvi = data[:current][:uvi]
    @description = data[:current][:weather][0][:main]
    @high = data[:daily][0][:temp][:max]
    @low = data[:daily][0][:temp][:min]
    @hourly_weather = data[:hourly][0,8].map {|hour| HourlyWeather.new(hour)}
  end
end
