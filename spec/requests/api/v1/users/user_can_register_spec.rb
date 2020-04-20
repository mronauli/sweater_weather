require "rails_helper"

describe "as a user" do
  context "when it makes a post request to 'api/v1/users'" do
    it "can create an account" do
      user_info = { email: "whatever@example.com", password: "password", password_confirmation: "password" }
      post "/api/v1/users", params: user_info, as: :json

      expect(response).to be_successful

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
