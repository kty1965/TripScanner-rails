Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }

  namespace :api, defaults: { format: 'json' } do
    scope "/v1", shallow_path: "/v1" do
      devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }
      resources :users, only: [:show]

      resources :trips
      resources :reviews do
        # member do
        #  get 'owned'
        #  get 'written'
        #  get 'all'
        # end
      end
    end
  end
end
