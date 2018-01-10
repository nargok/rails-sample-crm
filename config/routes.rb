Rails.application.routes.draw do
  config = Rails.application.config.baukis

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]

      # 特定の職員のログイン・ログアウト履歴を確認する
      resources :staff_members do
        resources :staff_events, only: [:index]
      end

      # すべての職員のログイン・ログアウト履歴を閲覧する
      resources :staff_events, only: [:index]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  root 'errors#not_found'
  get '*anything' => 'errors#not_found'

end
