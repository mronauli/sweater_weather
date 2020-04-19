class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :geocode, :current_weather, :hourly_weather, :daily_weather
end
