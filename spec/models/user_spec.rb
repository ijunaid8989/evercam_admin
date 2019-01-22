require 'rails_helper'

RSpec.describe User, type: :model do
  context "valid user" do
    it 'is database authenticable' do
      user = User.create(
        email: 'jonsnow@example.com',
        firstname: "jon",
        lastname: "snow",
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid_password?('password123')).to be_truthy
    end
  end
end
