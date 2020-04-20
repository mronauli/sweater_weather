class BackgroundService
  def get_data(location)
    conn = Faraday.new("https://api.pexels.com") do |req|
      req.headers["Authorization"] = ENV["PEXEL_API"]
      req.params["query"] = location
      req.params["per_page"] = 1
    end
    response = conn.get("/v1/search")
    JSON.parse(response.body, symbolize_names: true)
  end
end
