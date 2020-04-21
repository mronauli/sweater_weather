require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
  end

  describe '#generate_api_key' do
    before(:each) do
      @user = User.new(email: "whatever@example.com", password: "password", password_confirmation: "password")
    end

    it 'is called before save' do
      expect(@user).to receive(:generate_api_key)
      @user.save
    end

    it 'generates random api key' do
      expect(@user.api_key).to be_nil
      @user.save
      expect(@user.api_key).not_to be_nil
      expect(@user.api_key.length).to eq(32)
    end
  end
end
