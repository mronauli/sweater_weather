require "rails_helper"

describe "as a user" do
  context "when it makes a post request to 'api/v1/users'" do
    it "can create an account" do
      user_info = { email: "whatever@example.com", password: "password", password_confirmation: "password" }

      post "/api/v1/users", params: user_info, as: :json

      expect(response).to be_successful

      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data[:data][:attributes][:email]).to include(user_info[:email])
      expect(user_data[:data][:attributes][:api_key]).to_not be_empty
    end
    it "cannot create an account with an email already in db" do
      user = User.create( email: "whatever@example.com", password: "password", api_key: "asdfghjkl")

      user_info = { email: "whatever@example.com", password: "password", password_confirmation: "password" }

      post "/api/v1/users", params: user_info, as: :json

      error = JSON.parse(response.body)

      expect(error["status"]).to be(400)
    end
  end
end
