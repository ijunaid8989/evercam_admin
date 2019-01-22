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

  def response_body
    JSON.parse(response.body)
  end
end