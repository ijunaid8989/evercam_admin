Rails.application.routes.draw do
  root :to => "application#index"

  # devise_for :users, only: [:sessions]
  # get "/users/sign_in" => "application#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, only: [:sessions]
  # match "*path", to: "application#index", format: false, via: :get

  get "/v1/users" => "users#index"
  get "/v1/countries" => "users#countries"

  patch "/v1/update_multiple_users" => "users#update_multiple_users"
end
