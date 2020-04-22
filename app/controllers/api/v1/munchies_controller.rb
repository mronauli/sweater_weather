class Api::V1::MunchiesController < ApplicationController
  def show
     direction_data = GeocodeService.new.get_directions(params[:start], params[:end])
     direction = Direction.new(direction_data)
     conn = Faraday.new("https://api.yelp.com") do |req|
       req.headers["Authorization"] = ENV["YELP_API"]
       req.params["term"] = "food"
       req.params["categories"] = params[:food]
       req.params["location"] = params[:end]
       req.params["open_at"] = (Time.now + (direction.travel_time.tr('^0-9', '').to_i / 60)).to_i
     end
     response = conn.get("/v3/businesses/search")
     restaurant_data = JSON.parse(response.body, symbolize_names: true)
     restaurant_name = restaurant_data[:businesses][0][:name]
     restaurant_address = restaurant_data[:businesses][0][:location][:display_address]
  end
end
