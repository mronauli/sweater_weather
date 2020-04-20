require "rails_helper"

describe "as a user" do
  context "when it makes a request to 'api/v1/forecast' and specifies a location" do
    it "can see forecast data for that location" do

      get "/api/v1/antipode?location=argentina"

      expect(response).to be_successful
    end
  end
end
