require "rails_helper"

describe "as a user" do
  context "when it sends a request to 'api/v1/backgrounds' and specifies a location" do
    it "can see background image url related to that location" do

      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful
    end
  end
end
