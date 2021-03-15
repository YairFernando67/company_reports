# frozen_string_literal: true

class AddCompanyIdToSales < ActiveRecord::Migration[6.0]
  def change
    add_reference :sales, :company, foreign_key: true
  end
end
