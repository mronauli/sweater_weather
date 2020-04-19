class GeocodeService
  def get_data(location)
    conn = Faraday.new("https://maps.googleapis.com") do |req|
      req.params["key"] = ENV["GOOGLE_API_KEY"]
      req.params["address"] = location
    end
    response = conn.get("/maps/api/geocode/json")
    JSON.parse(response.body, symbolize_names: true)
  end
end
