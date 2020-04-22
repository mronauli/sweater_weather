require "rails_helper"

describe "as a user" do
  context "when it makes a get request to 'api/v1/munchies'" do
    it "can see food and forecast data for given city" do
      get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"

      expect(response).to be_successful

      munchie_trip = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
      expect(munchie_trip[:data][:type]).to eq("munchie")
      expect(munchie_trip[:data][:attributes][:end_location]).to_not be_empty
      expect(munchie_trip[:data][:attributes][:travel_time]).to_not be_empty
      expect(munchie_trip[:data][:attributes][:forecast]).to_not be_empty
      expect(munchie_trip[:data][:attributes][:restaurant][:name]).to_not be_empty
      expect(munchie_trip[:data][:attributes][:restaurant][:address]).to_not be_empty
    end
  end
end
