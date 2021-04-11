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
      get "/gmail_login", action: :gmail_login, controller: :facade
      get "/gmail_calendar_authorized", action: :gmail_calendar_authorized, controller: :facade
      get "/gmail_logout", action: :gmail_logout, controller: :facade

      post "/gmail_calendars", action: :create_calendar, controller: :gmail_calendars, as: :create_calendar
      delete "/calendars/:calendar_id", action: :delete_calendar, controller: :gmail_calendars, as: :delete_calendar
      get "/gmail_calendars", action: :gmail_calendars, controller: :gmail_calendars
      get "/list_events/:calendar_id", action: :events, controller: :gmail_calendars, as: :list_events
      post "/create_event/:calendar_id", action: :new_event, controller: :gmail_calendars, as: :create_event
    end
  end

  resources :google_sessions, only: [] do
    collection do
      match :login, via: %i[get post]
      get :callback
    end
  end
end
