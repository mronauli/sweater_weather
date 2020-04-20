class WeatherService
  def get_data_via_latlong(lat, long)
    response = conn.get("/data/2.5/onecall") do |req|
      req.params["lat"] = lat
      req.params["lon"] = long
      req.params["timezone"] = "UTC -7"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_data_via_city(city)
    response = conn.get("/data/2.5/weather") do |req|
      req.params["q"] = city
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def conn
      Faraday.new("https://api.openweathermap.org") do |req|
        req.params["appid"] = ENV["WEATHER_API"]
        req.params["units"] = "imperial"
      end
    end
end
