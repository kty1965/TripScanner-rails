Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }

  namespace :api, defaults: { format: 'json' } do
    scope "/v1", shallow_path: "/v1" do
      devise_for :users, :controllers => { :sessions => "api/user/sessions", :registrations => "api/user/registrations", :omniauth_callbacks => "api/users/omniauth_callbacks" }
      resources :users, only: [:show, :update]

      resources :trips  do
        collection do
         get 'owned'
         get 'joined'
        end
        member do
          put 'join'
          delete 'leave'
        end
      end

      resources :reviews, only: [:show, :update] do
        collection do
         get 'owned'
         get 'written'
         get 'pending'
        end
      end

      scope shallow_path: "user" do
        resources :users do
          resources :reviews, controller: 'user/reviews' do
            collection do
             get 'owned'
            end
          end
        end
      end

      # resources :users do
      #   resources :reviews, only: [:show, :update], shallow: true do
      #     collection do
      #      get 'owned'
      #      get 'written'
      #      get 'pending'
      #     end
      #   end
      # end
    end
  end
end
