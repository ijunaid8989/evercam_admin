require 'rails_helper'

RSpec.describe "Sessions" do
  it "signs user in and out" do
    user = User.create(
      email: 'test@example.com',
      firstname: "junaid",
      lastname: "farooq", 
      password: 'password123',
      password_confirmation: 'password123'
    )
    sign_in user
    get root_path
    expect(response).to render_template(:application)
    
    sign_out user
    get root_path
    expect(response).not_to render_template(:application)
  end
end