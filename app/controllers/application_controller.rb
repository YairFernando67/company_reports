# frozen_string_literal: true

# ApplicationController class
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
