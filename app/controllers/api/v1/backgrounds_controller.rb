class Api::V1::BackgroundsController < ApplicationController
  def show
    conn = Faraday.new("https://api.pexels.com") do |req|
      req.headers["Authorization"] = ENV["PEXEL_API"]
      req.params["query"] = params["location"][0..-3]
      req.params["per_page"] = 1
    end
    response = conn.get("/v1/search")
    background_data = JSON.parse(response.body, symbolize_names: true)
    image_url = background_data[:photos][0][:src][:landscape]
  end
end
