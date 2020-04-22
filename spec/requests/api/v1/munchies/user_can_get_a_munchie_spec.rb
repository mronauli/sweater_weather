require "rails_helper"

describe "as a user" do
  context "when it makes a post request to 'api/v1/munchies'" do
    it "can see food and forecast data for given city" do
      get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"

      expect(response).to be_successful

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
