class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index
    @current_user =  current_user.to_json
    @api_url = evercam_server
    render template: 'application'
  end

  def evercam_server
    if Rails.env.development?
      "http://localhost:4000"
    else
      "https://media.evercam.io"
    end
  end
end
