# frozen_string_literal: true

class Sales::DetailedReportDecorator < BaseDecorator
  def hello
    "<h1> Hello </h1>"
  end

  alias report hash
end
