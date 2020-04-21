require "rails_helper"

describe "as a user" do
  context "when it makes a post request to 'api/v1/sessions'" do
    it "can login" do
      user = User.create(email: "whatever@example.com", password: "password")

      user_info = { email: "whatever@example.com", password: "password" }

      post "/api/v1/sessions", params: user_info, as: :json
      expect(response).to be_successful
    end
  end
end
