Rails.application.routes.draw do
  resources :notifications
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
