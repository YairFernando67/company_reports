class Sales::SimpleReportDecorator < BaseDecorator

  def hello
    "Hello"
  end

  alias report hash
end
