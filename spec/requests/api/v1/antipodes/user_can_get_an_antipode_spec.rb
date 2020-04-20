require "rails_helper"

describe "as a user" do
  context "when it makes a request to 'api/v1/forecast' and specifies a location" do
    it "can see forecast data for that location" do

      get "/api/v1/antipode?location=argentina"

      expect(response).to be_successful

      antipode_weather_data = JSON.parse(response.body)
      expect(antipode_weather_data["data"]["attributes"]["search_location"]).to include("argentina")
      expect(antipode_weather_data["data"]["attributes"]["city_name"]).to_not be_empty
    end
  end
end
