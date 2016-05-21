Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  devise_for :users

  root "home#index"

  namespace :admin do
    root to: "questions#index"
    resources :questions
  end
end
