Rails.application.routes.draw do
  

  get 'factory/index'
  root to: 'home#index'
  get '/sale_report', action: :generate_report, controller: :sales
  devise_for :users

  # Design Patterns Routes
  scope :design_patterns, module: "design_patterns" do
    get 'builder', action: :index, controller: :builder
    get 'decorator', action: :index, controller: :decorator
    get 'factory', action: :index, controller: :factory
  end
end
