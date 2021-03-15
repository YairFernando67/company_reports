# frozen_string_literal: true

class ChangeDriverNumberTypeFromDrivers < ActiveRecord::Migration[6.0]
  def change
    change_column :drivers, :driver_number, :string
  end
end
