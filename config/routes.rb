# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  # Design Patterns Routes
  scope :design_patterns, module: :design_patterns do
    get "builder", action: :index, controller: :builder
    get "decorator", action: :index, controller: :decorator
    get "factory", action: :index, controller: :factory
    get "facade", action: :index, controller: :facade

    scope :facade do
      # root to: "facade#index"
      # get "/", action: :index, controller: :facade, as: :facade_main_page
      get "/google_calendar_redirect", action: :google_calendar_redirect, controller: :facade
      get "/callback", action: :callback, controller: :facade
      get "/calendars", action: :calendars, controller: :facade
      post "/calendars", action: :create_calendar, controller: :calendars, as: :create_calendar
      get "/list_events/:calendar_id", action: :events, controller: :facade, as: :list_events
      post "/create_event/:calendar_id", action: :new_event, controller: :facade, as: :create_event
    end
  end

  resources :google_sessions, only: [] do
    collection do
      match :login, via: %i[get post]
      get :callback
    end
  end
end
