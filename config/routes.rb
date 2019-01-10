Rails.application.routes.draw do
  root :to => "application#index"

  # devise_for :users, only: [:sessions]
  # get "/users/sign_in" => "application#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, only: [:sessions]

  get "/load_users" => "users#load_users"
  get "/init_users" => "users#init_users"
  match "*path", to: "application#index", format: false, via: :get
end
