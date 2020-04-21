require "rails_helper"

describe "as a user" do
  context "when it makes a request to 'api/v1/forecast' and specifies a location" do
    it "can see forecast data for that location" do

      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful
      forecast_data = JSON.parse(response.body, symbolize_names: true)
      expect(forecast_data[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(forecast_data[:data][:attributes][:daily_weather].count).to eq(7)
    end
  end
end
