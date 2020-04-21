require "rails_helper"

describe "as a user" do
  context "when it makes a post request to 'api/v1/sessions'" do
    it "can login with valid credentials" do
      user = User.create(email: "whatever@example.com", password: "password", api_key: "asdfghjkl")

      user_info = { email: "whatever@example.com", password: "password" }

      post "/api/v1/sessions", params: user_info, as: :json

      expect(response).to be_successful

      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data[:data][:attributes][:email]).to include(user.email)
      expect(user_data[:data][:attributes][:api_key]).to include(user.api_key)
    end
    it "cannot login with invalid credentials" do
      user = User.create(email: "whatever@example.com", password: "password", api_key: "asdfghjkl")

      user_info = { email: "whatever@example.com", password: "passw0rd" }

      post "/api/v1/sessions", params: user_info, as: :json

      error = JSON.parse(response.body)
      
      expect(error["status"]).to be(400)
    end
  end
end
