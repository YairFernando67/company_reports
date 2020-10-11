class Ui::Purchase::UiElements
  def display_report
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end