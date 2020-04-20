class WeatherService
  def get_data(lat, long)
    conn = Faraday.new("https://api.openweathermap.org") do |req|
      req.params["appid"] = ENV["WEATHER_API"]
      req.params["units"] = "imperial"
      req.params["lat"] = lat
      req.params["lon"] = long
      req.params["timezone"] = "UTC -7"
    end
    response = conn.get("/data/2.5/onecall")
    JSON.parse(response.body, symbolize_names: true)
  end
end
