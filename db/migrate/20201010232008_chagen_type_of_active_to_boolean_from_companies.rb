# frozen_string_literal: true

class ChagenTypeOfActiveToBooleanFromCompanies < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :active
    add_column :companies, :active, :boolean, default: false
  end
end
