# frozen_string_literal: true

# A constraint to allow certain routes to authenticated monkeys only
admin_constraint = lambda do |request|
  request.env['warden'].authenticated?(:admin_user) || Rails.env.development?
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  constraints admin_constraint do
    mount GoodJob::Engine => '/jobs'
  end

  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions,
  # otherwise 500. Can be used by load balancers and uptime monitors to verify
  # that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # scope module: 'api' do
  #   namespace :v1 do
  #   end
  # end

  # Render dynamic PWA files from app/views/pwa/*
  # (Manifest linked from application.html.erb)
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker

  # get '/:locale' => 'home#index', as: 'root_i18n'

  # Defines the root path route ("/")
  root 'home#index'
end
