class Sales::FullReportDecorator < BaseDecorator
  def hello
    "Hello"
  end

  alias report hash
end
