class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index
    @current_user =  current_user.to_json
    render template: 'application'
  end
end
