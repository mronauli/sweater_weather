require "rails_helper"

describe "as a registered user" do
  context "when it makes a post request to 'api/v1/road_trip'" do
    it "can see trip data for specified locations if authorized" do
      user = User.create(email: "whatever@example.com", password: "password", api_key: "asdfghjkl")

      valid_params = { api_key: user.api_key, origin: "Denver,CO", destination: "Pueblo,CO" }

      post "/api/v1/road_trip", params: valid_params, as: :json

      expect(response).to be_successful

      trip_data = JSON.parse(response.body, symbolize_names: true)

      expect(trip_data[:data][:attributes][:travel_time]).to include("2 hours")
    end

    it "can see trip data for specified locations if not authorized" do
      user = User.create(email: "whatever@example.com", password: "password", api_key: "asdfghjkl")

      valid_params = { api_key: "lkjhgfdsa", origin: "Denver,CO", destination: "Pueblo,CO" }

      post "/api/v1/road_trip", params: valid_params, as: :json

      error = JSON.parse(response.body)

      expect(error["status"]).to be(401)
    end
  end
end
