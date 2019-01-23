require 'rails_helper'

RSpec.describe "API V1 Users", type: 'request' do
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

  it "should return valid json for vuetable" do
    sign_in @user
    get "/v1/users", :params => { :sort => "name|desc", :page => 1, :per_page => 10 }

    expect(response_body.keys).to match_array([
      "current_page",
      "data",
      "from",
      "last_page",
      "next_page_url",
      "per_page",
      "prev_page_url",
      "to",
      "total"
    ])
    expect(response_body["per_page"]).to eq(10)
    expect(response_body["total"]).to eq(1)
  end

  it "should update user's country and payment_type" do
    sign_in @user
    patch "/v1/update_multiple_users", :params => { :country => 3, :payment_type => 2, :ids => @user.id }

    expect(response_body["success"]).to eq(true)
  end

  it "should fail due to params are missing while updating user" do
    sign_in @user
    patch "/v1/update_multiple_users", :params => { :ids => @user.id }

    expect(response_body["success"]).to eq(false)
    expect(response_body["errors"]["country"]).to eq("Country params are missing.")
    expect(response_body["errors"]["payment_type"]).to eq("Payment_type params are missing.")
  end

  def response_body
    JSON.parse(response.body)
  end
end