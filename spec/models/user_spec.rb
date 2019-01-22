require 'rails_helper'

RSpec.describe User, type: :model do
  setup do
    @user = User.create(
      email: "jonsnow@example.com",
      firstname: "jon",
      lastname: "snow",
      password: "password123",
      password_confirmation: "password123",
      is_admin: true
    )
  end

  context "valid user" do
    it "is database authenticable" do
      expect(@user.valid_password?("password123")).to be_truthy
    end

    it "is an admin" do
      expect(@user.active_for_authentication?).to be_truthy
    end
  end
end
