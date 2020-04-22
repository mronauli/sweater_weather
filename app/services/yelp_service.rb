class YelpService
  def get_data(type, destination, time)
    conn = Faraday.new("https://api.yelp.com") do |req|
      req.headers["Authorization"] = ENV["YELP_API"]
      req.params["term"] = "food"
      req.params["categories"] = type
      req.params["location"] = destination
      req.params["open_at"] = time
    end
    response = conn.get("/v3/businesses/search")
    restaurant_data = JSON.parse(response.body, symbolize_names: true)
  end
end
