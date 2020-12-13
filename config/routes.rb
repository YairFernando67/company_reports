Rails.application.routes.draw do
  
  
  root to: 'home#index'
  get '/sale_report', action: :generate_report, controller: :sales
  devise_for :users

  # Design Patterns Routes
  scope :design_patterns, module: "design_patterns" do
    get 'builder/index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
