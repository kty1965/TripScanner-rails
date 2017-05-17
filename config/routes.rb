Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }

  namespace :api, defaults: { format: 'json' } do
    scope "/v1", shallow_path: "/v1" do
      devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }
      resources :users, only: [:show]

      resources :trips  do
        collection do
         get 'owned'
         get 'joined'
        end
      end
      resources :reviews, only: [:show, :create] do
        collection do
         get 'owned'
         get 'written'
        end
      end
    end
  end
end
