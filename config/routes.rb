Rails.application.routes.draw do
  root to: 'home#index'
  get '/purchase_report', action: :generate_report, controller: :purchases
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
