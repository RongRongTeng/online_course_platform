# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :admin do
    resources :categories
    resources :courses
  end

  mount Application => '/'
end
