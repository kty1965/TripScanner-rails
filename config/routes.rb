Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations" }

  namespace :api, defaults: { format: 'json' } do
    scope "/v1", shallow_path: "/v1" do
      devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations" }
      resources :users, only: [:show]
    end
  end
end
