require 'rails_helper'

RSpec.describe "Sessions" do
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

  it "signs user in and out" do
    sign_in @user
    get root_path
    expect(response).to render_template(:application)
    
    sign_out @user
    get root_path
    expect(response).not_to render_template(:application)
  end

  it "redirects user if not admin" do
    @user.is_admin = false
    @user.save

    sign_in @user
    get root_path
    expect(response).not_to render_template(:application)
  end
end