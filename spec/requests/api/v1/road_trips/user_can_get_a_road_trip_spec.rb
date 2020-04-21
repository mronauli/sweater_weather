require "rails_helper"

describe "as a registered user" do
  context "when it makes a post request to 'api/v1/road_trip'" do
    it "can see trip data for specified locations" do
      user = User.create(email: "whatever@example.com", password: "password")

      valid_params = { api_key: user.api_key, origin: "Denver,CO", destination: "Pueblo,CO" }

      post "/api/v1/road_trip", params: valid_params, as: :json

      expect(response).to be_successful
    end
  end
end
