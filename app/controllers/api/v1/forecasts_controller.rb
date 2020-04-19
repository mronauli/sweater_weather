class Api::V1::ForecastsController < ApplicationController
  def show
    geocode_data = GeocodeService.new.get_data(params["location"])
    filtered_data = Geocode.new(geocode_data)
    conn = Faraday.new("https://api.openweathermap.org") do |req|
      req.params["appid"] = ENV["WEATHER_API"]
      req.params["units"] = "imperial"
      req.params["lat"] = filtered_data.lat
      req.params["lon"] = filtered_data.long
      req.params["timezone"] = "UTC -7"
    end
    response = conn.get("/data/2.5/onecall")
    weather_data = JSON.parse(response.body, symbolize_names: true)
    # current
    time = weather_data[:current][:dt]
    sunrise = weather_data[:current][:sunrise]
    sunrise = weather_data[:current][:sunset]
    feels_like = weather_data[:current][:feels_like]
    humidity = weather_data[:current][:humidity]
    visibility = weather_data[:current][:visibility]
    uvi = weather_data[:current][:uvi]
    description = weather_data[:current][:weather][0][:main]
    high = weather_data[:daily][0][:temp][:max]
    low = weather_data[:daily][0][:temp][:min]
    # hourly (8 hours)
    hours = weather_data[:hourly][0,8]

    date = hours.map do |hour|
      hour[:dt]
    end

    temp = hours.map do |hour|
      hour[:temp]
    end

    icon = hours.map do |hour|
      hour[:weather][0][:icon]
    end
    #daily (7 days)

    days = weather_data[:daily][0,7]

    day = days.map do |day|
      day[:dt]
    end

    max = days.map do |day|
      day[:temp][:max]
    end

    min = days.map do |day|
      day[:temp][:min]
    end

    desc = days.map do |day|
      day[:weather][0][:main]
    end

    icon = days.map do |day|
      day[:weather][0][:icon]
    end

    rain = days.map do |day|
      day[:rain]
    end
  end
end
